//
//  DeleteCategoryUseCase.swift
//  Domain
//
//  Created by 노원진 on 11/7/24.
//

public protocol DeleteCategoryUseCase {
    func execute(_ category: Category) throws
}

public final class DeleteCategoryUseCaseImpl: DeleteCategoryUseCase {
    private let categoryRepository: CategoryRepository
    
    public init(_ categoryRepository: CategoryRepository) {
        self.categoryRepository = categoryRepository
    }
    
    public func execute(_ category: Category) throws {
        try self.categoryRepository.delete(category: category)
    }
}
