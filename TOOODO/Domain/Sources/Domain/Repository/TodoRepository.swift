//
//  TodoRepository.swift
//  Domain
//
//  Created by 노원진 on 11/7/24.
//

import Combine

public protocol TodoRepository {
    func getTodos(categoryId: String) throws -> AnyPublisher<Array<Todo>, Error>
    func upsertTodo(categoryId: String, todo: Todo) throws
    func deleteTodo(todoId: String) throws
}
