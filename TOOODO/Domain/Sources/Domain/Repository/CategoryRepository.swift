//
//  LocalRepository.swift
//  Domain
//
//  Created by 노원진 on 11/7/24.
//

import Combine

public protocol CategoryRepository {
    func get() -> AnyPublisher<Array<Category>, Error>
    func upsert(category: Category) throws
    func delete(category: Category) throws
}
