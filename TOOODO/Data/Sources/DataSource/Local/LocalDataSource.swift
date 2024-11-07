//
//  LocalDataSource.swift
//  Data
//
//  Created by 노원진 on 11/5/24.
//

import Foundation
import RealmSwift

public protocol LocalDataSource {
    func getCategories() -> Array<CategoryDto>
    func upsertCategory(category: CategoryDto) throws
    func deleteCategory(categoryId: ObjectId) throws
    
    func getTodos(categoryId: ObjectId) -> Array<TodoDto>
    func upsertTodo(categoryId: ObjectId, todo: TodoDto) throws
    func deleteTodo(todoId: ObjectId) throws
}

public class LocalDataSourceImpl: LocalDataSource {
    private let realm: Realm
    
    public init() {
        self.realm = try! Realm()
    }
    
    internal init(_ realm: Realm) {
        self.realm = realm
    }
    
    public func getCategories() -> Array<CategoryDto> {
        return Array(realm.objects(CategoryDto.self))
    }
    
    public func upsertCategory(category: CategoryDto) throws {
        do {
            let old = realm.objects(CategoryDto.self).first(where: { $0.id == category.id })
            
            try realm.write {
                if (old == nil) {
                    realm.add(category)
                } else {
                    old?.category = category.category
                    old?.categoryDes = category.categoryDes
                    old?.color = category.color
                    old?.todos = category.todos
                }
            }
        } catch {
            throw error
        }
    }
    
    public func deleteCategory(categoryId: ObjectId) throws {
        do {
            guard let category = realm.objects(CategoryDto.self).first(where: { $0.id == categoryId }) else { return }
            
            try realm.write {
                realm.delete(category)
            }
        } catch {
            throw error
        }
    }
    
    public func getTodos(categoryId: ObjectId) -> Array<TodoDto> {
        guard let category = realm.objects(CategoryDto.self).first(where: { $0.id == categoryId}) else { return [] }
        
        return Array(category.todos)
    }
    
    public func upsertTodo(categoryId: ObjectId, todo: TodoDto) throws {
        do {
            let category = realm.objects(CategoryDto.self).first(where: { $0.id == categoryId })
            
            try realm.write {
                if let old = category?.todos.first(where: { $0.id == todo.id }) {
                    old.todo = todo.todo
                    old.completed = todo.completed
                } else {
                    category?.todos.append(todo)
                }
            }
        } catch {
            throw error
        }
    }
    
    public func deleteTodo(todoId: ObjectId) throws {
        do {
            guard let todo = realm.objects(TodoDto.self).first(where: { $0.id == todoId }) else { return }
            
            try realm.write {
                realm.delete(todo)
            }
        } catch {
            throw error
        }
    }
}
