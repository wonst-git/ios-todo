//
//  CategoryEntity.swift
//  Domain
//
//  Created by 노원진 on 11/7/24.
//

public struct Category {
    public let id: String
    public let category: String
    public let categoryDes: String
    public let color: Int
    public let todos: [Todo]
    
    public init(id: String, category: String, categoryDes: String, color: Int, todos: [Todo]) {
        self.id = id
        self.category = category
        self.categoryDes = categoryDes
        self.color = color
        self.todos = todos
    }
}
