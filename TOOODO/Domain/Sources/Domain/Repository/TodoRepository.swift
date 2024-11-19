//
//  TodoRepository.swift
//  Domain
//
//  Created by 노원진 on 11/7/24.
//

import Combine

public protocol TodoRepository {
    func get(categoryId: String) throws -> AnyPublisher<Array<Todo>, Error>
    func upsert(categoryId: String, todo: Todo) throws
    func delete(todo: Todo) throws
}
