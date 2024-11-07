//
//  TodoEntity.swift
//  Domain
//
//  Created by 노원진 on 11/7/24.
//

public struct TodoEntity {
    public let id: String
    public let todo: String
    public let completed: Bool
    
    public init(id: String, todo: String, completed: Bool) {
        self.id = id
        self.todo = todo
        self.completed = completed
    }
}
