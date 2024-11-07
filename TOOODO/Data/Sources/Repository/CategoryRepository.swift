//
//  CategoryRepository.swift
//  Data
//
//  Created by 노원진 on 11/7/24.
//

import Domain
import RealmSwift

public class CategoryRepositoryImpl: CategoryRepository {
    private let localDataSource: LocalDataSource
    
    public init(localDataSource: LocalDataSource) {
        self.localDataSource = localDataSource
    }
    
    public func getCategories() -> Array<Domain.CategoryEntity> {
        localDataSource.getCategories().map { $0.toEntity() }
    }
    
    public func upsertCategory(category: Domain.CategoryEntity) {
        try! localDataSource.upsertCategory(category: CategoryDto.fromEntity(category))
    }
    
    public func deleteCategory(categoryId: String) {
        try! localDataSource.deleteCategory(categoryId: ObjectId(string: categoryId))
    }
}
