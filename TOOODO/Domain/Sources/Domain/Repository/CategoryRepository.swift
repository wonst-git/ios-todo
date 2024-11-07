//
//  LocalRepository.swift
//  Domain
//
//  Created by 노원진 on 11/7/24.
//

public protocol CategoryRepository {
    func getCategories() -> Array<CategoryEntity>
    func upsertCategory(category: CategoryEntity)
    func deleteCategory(categoryId: String)
}
