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
    
    public func get() -> AnyPublisher<Array<Domain.Category>, Error> {
        localDataSource.get()
            .map {
                $0.map { $0.toDomain() }
            }
            .eraseToAnyPublisher()
    }
    
    public func upsert(category: Domain.Category) throws {
        try localDataSource.upsert(category: CategoryDto.fromDomain(category))
    }
    
    public func delete(category: Domain.Category) throws {
        try localDataSource.delete(category: CategoryDto.fromDomain(category))
    }
}
