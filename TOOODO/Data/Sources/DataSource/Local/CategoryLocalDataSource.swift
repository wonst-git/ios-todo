//
//  LocalDataSource.swift
//  Data
//
//  Created by 노원진 on 11/5/24.
//

import Foundation
import RealmSwift

public protocol CategoryLocalDataSource {
    func getCategories() -> Array<CategoryDto>
    func upsertCategory(category: CategoryDto) throws
    func deleteCategory(categoryId: ObjectId) throws
}

public class CategoryLocalDataSourceImpl: CategoryLocalDataSource {
    private let realm: Realm
    
    public init() {
        self.realm = try! Realm()
    }
    
    internal init(_ realm: Realm) {
        self.realm = realm
    }
    
    public func getCategories() -> Array<CategoryDto> {
        return Array(realm.objects(CategoryDto.self))
    }
    
    public func upsertCategory(category: CategoryDto) throws {
        let old = realm.objects(CategoryDto.self).first(where: { $0.id == category.id })
        
        try realm.write {
            if (old == nil) {
                realm.add(category)
            } else {
                old?.category = category.category
                old?.categoryDes = category.categoryDes
                old?.color = category.color
                old?.todos = category.todos
            }
        }
    }
    
    public func deleteCategory(categoryId: ObjectId) throws {
        guard let category = realm.objects(CategoryDto.self).first(where: { $0.id == categoryId }) else { return }
        
        try realm.write {
            realm.delete(category)
        }
    }
}
