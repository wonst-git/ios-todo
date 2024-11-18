//
//  LocalRepository.swift
//  Domain
//
//  Created by 노원진 on 11/7/24.
//

import Combine

public protocol CategoryRepository {
    func getCategories() -> AnyPublisher<Array<Category>, Error>
    func upsertCategory(category: Category) throws
    func deleteCategory(categoryId: String) throws
}
