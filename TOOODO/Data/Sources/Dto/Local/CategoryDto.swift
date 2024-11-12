//
//  CategoryDto.swift
//  Data
//
//  Created by 노원진 on 11/5/24.
//

import RealmSwift
import Domain

public class CategoryDto: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var category: String
    @Persisted var categoryDes: String
    @Persisted var color: Int
    @Persisted var todos: List<TodoDto>
}

extension CategoryDto {
    func toDomain() -> Category {
        Category(id: self.id.stringValue, category: self.category, categoryDes: self.categoryDes, color: self.color, todos: self.todos.map{ $0.toDomain() })
    }
    
    class func fromDomain(_ entity: Category) -> CategoryDto {
        if entity.id.isEmpty {
            return CategoryDto(value: [
                "category": entity.category,
                "categoryDes": entity.categoryDes,
                "color": entity.color,
                "todos": entity.todos.map { TodoDto.fromDomain(entity: $0)}
            ])
        } else {
            return CategoryDto(value: [
                "id": try! ObjectId(string: entity.id),
                "category": entity.category,
                "categoryDes": entity.categoryDes,
                "color": entity.color,
                "todos": entity.todos.map { TodoDto.fromDomain(entity: $0)}
            ])
        }
    }
}
