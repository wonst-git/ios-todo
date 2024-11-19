//
//  UpsertCategoryUseCase.swift
//  Domain
//
//  Created by 노원진 on 11/7/24.
//

public protocol UpsertCategoryUseCase {
    func execute(_ category: Category) throws
}

public final class UpsertCategoryUseCaseImpl: UpsertCategoryUseCase {
    private let categoryRepository: CategoryRepository
    
    public init(_ categoryRepository: CategoryRepository) {
        self.categoryRepository = categoryRepository
    }
    
    public func execute(_ category: Category) throws {
        try self.categoryRepository.upsert(category: category)
    }
}
