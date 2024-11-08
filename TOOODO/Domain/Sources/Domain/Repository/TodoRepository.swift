//
//  TodoRepository.swift
//  Domain
//
//  Created by 노원진 on 11/7/24.
//

public protocol TodoRepository {
    func getTodos(categoryId: String) throws -> Array<Todo>
    func upsertTodo(categoryId: String, todo: Todo) throws
    func deleteTodo(todoId: String) throws
}
