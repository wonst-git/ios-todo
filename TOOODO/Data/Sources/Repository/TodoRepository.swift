//
//  TodoRepository.swift
//  Data
//
//  Created by 노원진 on 11/7/24.
//

import Domain
import Combine
import RealmSwift

public class TodoRepositoryImpl: TodoRepository {
    private let localDataSource: TodoLocalDataSource
    
    public init(localDataSource: TodoLocalDataSource) {
        self.localDataSource = localDataSource
    }
    
    public func get(categoryId: String) throws -> AnyPublisher<Array<Domain.Todo>, Error> {
        return try localDataSource.get(categoryId: ObjectId(string: categoryId))
            .map {
                $0.map { $0.toDomain() }
            }
            .eraseToAnyPublisher()
    }
    
    public func upsert(categoryId: String, todo: Domain.Todo) throws {
        try localDataSource.upsert(categoryId: ObjectId(string: categoryId), todo: TodoDto.fromDomain(entity: todo))
    }
    
    public func delete(todo: Todo) throws {
        try localDataSource.delete(todo: TodoDto.fromDomain(entity: todo))
    }
}
