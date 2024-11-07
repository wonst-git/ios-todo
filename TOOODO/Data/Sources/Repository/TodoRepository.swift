//
//  TodoRepository.swift
//  Data
//
//  Created by 노원진 on 11/7/24.
//

import Domain
import RealmSwift

public class TodoRepositoryImpl: TodoRepository {
    private let localDataSource: LocalDataSource
    
    public init(localDataSource: LocalDataSource) {
        self.localDataSource = localDataSource
    }
    
    public func getTodos(categoryId: String) -> Array<Domain.TodoEntity> {
        return localDataSource.getTodos(categoryId: try! ObjectId(string: categoryId)).map { $0.toEntity() }
    }
    
    public func upsertTodo(categoryId: String, todo: Domain.TodoEntity) {
        try! localDataSource.upsertTodo(categoryId: ObjectId(string: categoryId), todo: TodoDto.fromEntity(entity: todo))
    }
    
    public func deleteTodo(todoId: String) {
        try! localDataSource.deleteTodo(todoId: ObjectId(string: todoId))
    }
}
