//
//  LocalDataSource.swift
//  Data
//
//  Created by 노원진 on 11/5/24.
//

import Foundation
import RealmSwift

public protocol TodoLocalDataSource {
    func getTodos(categoryId: ObjectId) -> Array<TodoDto>
    func upsertTodo(categoryId: ObjectId, todo: TodoDto) throws
    func deleteTodo(todoId: ObjectId) throws
}

public class TodoLocalDataSourceImpl: TodoLocalDataSource {
    private let realm: Realm
    
    public init() {
        self.realm = try! Realm()
    }
    
    internal init(_ realm: Realm) {
        self.realm = realm
    }
    
    public func getTodos(categoryId: ObjectId) -> Array<TodoDto> {
        guard let category = realm.objects(CategoryDto.self).first(where: { $0.id == categoryId}) else { return [] }
        
        return Array(category.todos)
    }
    
    public func upsertTodo(categoryId: ObjectId, todo: TodoDto) throws {
        let category = realm.objects(CategoryDto.self).first(where: { $0.id == categoryId })
        
        try realm.write {
            if let old = category?.todos.first(where: { $0.id == todo.id }) {
                old.todo = todo.todo
                old.completed = todo.completed
            } else {
                category?.todos.append(todo)
            }
        }
    }
    
    public func deleteTodo(todoId: ObjectId) throws {
        guard let todo = realm.objects(TodoDto.self).first(where: { $0.id == todoId }) else { return }
        
        try realm.write {
            realm.delete(todo)
        }
    }
}
