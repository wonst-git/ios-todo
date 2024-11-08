//
//  TodoRepository.swift
//  Data
//
//  Created by 노원진 on 11/7/24.
//

import Domain
import RealmSwift

public class TodoRepositoryImpl: TodoRepository {
    private let localDataSource: TodoLocalDataSource
    
    public init(localDataSource: TodoLocalDataSource) {
        self.localDataSource = localDataSource
    }
    
    public func getTodos(categoryId: String) throws -> Array<Domain.Todo> {
        return try localDataSource.getTodos(categoryId: ObjectId(string: categoryId)).map { $0.toDomain() }
    }
    
    public func upsertTodo(categoryId: String, todo: Domain.Todo) throws {
        try localDataSource.upsertTodo(categoryId: ObjectId(string: categoryId), todo: TodoDto.fromDomain(entity: todo))
    }
    
    public func deleteTodo(todoId: String) throws {
        try localDataSource.deleteTodo(todoId: ObjectId(string: todoId))
    }
}
