//
//  LocalDataSource.swift
//  Data
//
//  Created by 노원진 on 11/5/24.
//

import Foundation
import RealmSwift

import Combine

public protocol CategoryLocalDataSource {
    func get() -> AnyPublisher<Array<CategoryDto>, Error>
    func upsert(category: CategoryDto) throws
    func delete(category: CategoryDto) throws
}

public class CategoryLocalDataSourceImpl: RealmManager, CategoryLocalDataSource {
    public func get() -> AnyPublisher<Array<CategoryDto>, Error> {
        return super.getPublisher(CategoryDto.self) { categories in
            categories.sorted(by: \.date, ascending: false)
        }
    }
    
    public func upsert(category: CategoryDto) throws {
        try super.upsert(category)
    }
    
    public func delete(category: CategoryDto) throws {
        try super.delete(category)
    }
}
