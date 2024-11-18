//
//  CategoryDto.swift
//  Data
//
//  Created by 노원진 on 11/5/24.
//

import RealmSwift
import Domain
import Foundation

public class CategoryDto: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var category: String
    @Persisted var categoryDes: String
    @Persisted var color: Int
    @Persisted var todos: List<TodoDto>
    @Persisted var date: Date
}

extension CategoryDto {
    func toDomain() -> Domain.Category {
        Category(id: self.id.stringValue, category: self.category, categoryDes: self.categoryDes, color: self.color, todos: self.todos.map{ $0.toDomain() })
    }
    
    class func fromDomain(_ entity: Domain.Category) -> CategoryDto {
        if entity.id.isEmpty {
            return CategoryDto(value: [
                "category": entity.category,
                "categoryDes": entity.categoryDes,
                "color": entity.color,
                "todos": entity.todos.map { TodoDto.fromDomain(entity: $0)},
                "date": Date()
            ])
        } else {
            return CategoryDto(value: [
                "id": try! ObjectId(string: entity.id),
                "category": entity.category,
                "categoryDes": entity.categoryDes,
                "color": entity.color,
                "todos": entity.todos.map { TodoDto.fromDomain(entity: $0)},
                "date": Date()
            ])
        }
    }
}
