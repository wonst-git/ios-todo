//
//  GetTodosUseCase.swift
//  Domain
//
//  Created by 노원진 on 11/7/24.
//

public protocol GetTodosUseCase {
    
}

public final class GetTodosUseCaseImpl: GetTodosUseCase {
    private let todoRepository: TodoRepository
    
    public init(_ todoRepository: TodoRepository) {
        self.todoRepository = todoRepository
    }
}
