//
//  GetCategoriesUseCase.swift
//  Domain
//
//  Created by 노원진 on 11/7/24.
//

import Combine

public protocol GetCategoriesUseCase {
    func execute() -> AnyPublisher<Array<Category>, Error>
}

public final class GetCategoriesUseCaseImpl: GetCategoriesUseCase {
    private let categoryRepository: CategoryRepository
    
    public init(_ categoryRepository: CategoryRepository) {
        self.categoryRepository = categoryRepository
    }
    
    public func execute() -> AnyPublisher<Array<Category>, Error> {
        return self.categoryRepository.get()
    }
}
