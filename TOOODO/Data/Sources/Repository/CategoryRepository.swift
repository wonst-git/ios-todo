//
//  CategoryRepository.swift
//  Data
//
//  Created by 노원진 on 11/7/24.
//

import Domain
import RealmSwift
import Combine

public class CategoryRepositoryImpl: CategoryRepository {
    private let localDataSource: CategoryLocalDataSource
    
    public init(localDataSource: CategoryLocalDataSource) {
        self.localDataSource = localDataSource
    }
    
    public func getCategories() -> AnyPublisher<Array<Domain.Category>, Error> {
        localDataSource.getCategories()
            .map {
                $0.map { $0.toDomain() }
            }
            .eraseToAnyPublisher()
    }
    
    public func upsertCategory(category: Domain.Category) throws {
        try localDataSource.upsertCategory(category: CategoryDto.fromDomain(category))
    }
    
    public func deleteCategory(categoryId: String) throws {
        try localDataSource.deleteCategory(categoryId: ObjectId(string: categoryId))
    }
}
