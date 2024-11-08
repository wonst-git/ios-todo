//
//  LocalRepository.swift
//  Domain
//
//  Created by 노원진 on 11/7/24.
//

public protocol CategoryRepository {
    func getCategories() -> Array<Category>
    func upsertCategory(category: Category) throws
    func deleteCategory(categoryId: String) throws
}
