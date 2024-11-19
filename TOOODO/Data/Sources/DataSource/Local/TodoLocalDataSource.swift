//
//  LocalDataSource.swift
//  Data
//
//  Created by 노원진 on 11/5/24.
//

import Foundation
import RealmSwift
import Combine

public protocol TodoLocalDataSource {
    func get(categoryId: ObjectId) -> AnyPublisher<Array<TodoDto>, Error>
    func upsert(categoryId: ObjectId, todo: TodoDto) throws
    func delete(todo: TodoDto) throws
}

public class TodoLocalDataSourceImpl: RealmManager, TodoLocalDataSource {
    public func get(categoryId: ObjectId) -> AnyPublisher<Array<TodoDto>, Error> {
        return getPublisher(CategoryDto.self) {
            $0.where {
                $0.id == categoryId
            }
        }
        .map {
            Array($0.first?.todos ?? List())
        }
        .eraseToAnyPublisher()
    }
    
    public func upsert(categoryId: ObjectId, todo: TodoDto) throws {
        guard let category = (
            super.get(CategoryDto.self) {
                $0.where {
                    $0.id == categoryId
                }
            }.first
        ) else {
            return
        }
        
        if (category.todos.contains { $0.id == todo.id }) {
            try super.upsert(category)
        } else {
            var newTodos = Array(category.todos)
            newTodos.append(todo)
            
            let newCategory = CategoryDto(
                value: [
                    "id": category.id,
                    "category": category.category,
                    "categoryDes": category.categoryDes,
                    "color": category.color,
                    "todos": newTodos
                ]
            )
            
            try super.upsert(newCategory)
        }
    }
    
    public func delete(todo: TodoDto) throws {
        try super.delete(todo)
    }
}
