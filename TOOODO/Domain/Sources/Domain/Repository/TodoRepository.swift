//
//  TodoRepository.swift
//  Domain
//
//  Created by 노원진 on 11/7/24.
//

public protocol TodoRepository {
    func getTodos(categoryId: String) -> Array<TodoEntity>
    func upsertTodo(categoryId: String, todo: TodoEntity)
    func deleteTodo(todoId: String)
}
