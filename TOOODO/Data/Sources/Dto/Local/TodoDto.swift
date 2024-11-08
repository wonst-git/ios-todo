//
//  TodoDto.swift
//  Data
//
//  Created by 노원진 on 11/5/24.
//

import RealmSwift
import Domain

public class TodoDto: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var todo: String
    @Persisted var completed: Bool
}

extension TodoDto {
    func toDomain() -> Todo {
        Todo(id: self.id.stringValue, todo: self.todo, completed: self.completed)
    }
    
    class func fromDomain(entity: Todo) -> TodoDto {
        let id: ObjectId = entity.id.isEmpty ? ObjectId() : try! ObjectId(string: entity.id)
        
        return TodoDto(value: [
            "id": id,
            "todo": entity.todo,
            "completed": entity.completed
        ])
    }
}
