//
//  UpsertTodoUseCase.swift
//  Domain
//
//  Created by 노원진 on 11/7/24.
//

public protocol UpsertTodoUseCase {
    func execute(categoryId: String, todo: Todo) throws
}

public final class UpsertTodoUseCaseImpl: UpsertTodoUseCase {
    private let todoRepository: TodoRepository
    
    public init(_ todoRepository: TodoRepository) {
        self.todoRepository = todoRepository
    }
    
    public func execute(categoryId: String, todo: Todo) throws {
        try todoRepository.upsertTodo(categoryId: categoryId, todo: todo)
    }
}
