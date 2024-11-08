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
        Category(id: self.id.stringValue, category: self.category, categoryDes: self.categoryDes, color: self.color, todos: self.todos.map{ $0.toEntity() })
    }
    
    class func fromDomain(_ entity: Category) -> CategoryDto {
        let id: ObjectId = entity.id.isEmpty ? ObjectId() : try! ObjectId(string: entity.id)
        
        return CategoryDto(value: [
            "id": id,
            "category": entity.category,
            "categoryDes": entity.categoryDes,
            "color": entity.color,
            "todos": entity.todos.map { TodoDto.fromEntity(entity: $0)}
        ])
    }
}
