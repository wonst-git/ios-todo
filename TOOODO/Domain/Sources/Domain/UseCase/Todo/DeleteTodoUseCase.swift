//
//  DeleteTodoUseCase.swift
//  Domain
//
//  Created by 노원진 on 11/7/24.
//

public protocol DeleteTodoUseCase {
    
}

public final class DeleteTodoUseCaseImpl: DeleteTodoUseCase {
    private let todoRepository: TodoRepository
    
    public init(_ todoRepository: TodoRepository) {
        self.todoRepository = todoRepository
    }
}
