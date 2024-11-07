//
//  Untitled.swift
//  Data
//
//  Created by 노원진 on 11/7/24.
//

import Testing
@testable import Data
@testable import RealmSwift

struct LocalDataSourceTests {
    private let realm: Realm
    private let localDataSource: LocalDataSource
    
    init() {
        realm = try! Realm(configuration: .init(inMemoryIdentifier: "TOOODOTests"))
        localDataSource = LocalDataSourceImpl(realm)
    }
    
    @Test func categoryCRUDTest() {
        // Get Test
        let categories = self.localDataSource.getCategories()
        
        print("(category)get test: \(localDataSource.getCategories())")
        #expect(categories.isEmpty)
        
        // Save Test
        let category = CategoryDto(value: [
            "category": "Category1",
            "categoryDes": "First Category",
            "color": 0xffffffff
        ])
                                   
        try! self.localDataSource.upsertCategory(category: category)
        
        print("id: \(category.id)  convertid: \(try! ObjectId(string: category.id.stringValue))")
        
        print("(category)save test: \(localDataSource.getCategories())")
        #expect(!localDataSource.getCategories().isEmpty)
        
        // Update Test
        let newCategory = CategoryDto(value: [
            "id": category.id,
            "category": "Category1 Updated",
            "categoryDes": "First Category",
            "color": 0xffffffff
        ])
        
        try! self.localDataSource.upsertCategory(category: newCategory)
        
        print("(category)update test: \(localDataSource.getCategories())")
        #expect(localDataSource.getCategories().first?.category == "Category1 Updated")
        
        // Delete Test
        try! localDataSource.deleteCategory(categoryId: category.id)
        
        print("(category)delete test: \(localDataSource.getCategories())")
        #expect(localDataSource.getCategories().isEmpty)
    }
    
    @Test
    func todoCRUDTest() {
        let category = CategoryDto(value: [
            "category": "Category1",
            "categoryDes": "First Category",
            "color": 0xffffffff
        ])
        
        try! localDataSource.upsertCategory(category: category)
        
        // Get Test
        let todos = localDataSource.getTodos(categoryId: category.id)
        
        print("(todo)get test: \(todos)")
        #expect(todos.isEmpty)
        
        // Save Test
        let todo = TodoDto(value: [
            "todo": "Todo1",
            "completed": false
        ])
        
        try! localDataSource.upsertTodo(categoryId: category.id, todo: todo)
        
        print("(todo)save test: \(localDataSource.getTodos(categoryId: category.id))")
        #expect(localDataSource.getTodos(categoryId: category.id).first?.todo == "Todo1")
        
        // Update Test
        let newTodo = TodoDto(value: [
            "id": todo.id,
            "todo": "Todo1 Updated",
            "completed": true
        ])
        
        try! localDataSource.upsertTodo(categoryId: category.id, todo: newTodo)
        
        print("(todo)update test: \(localDataSource.getTodos(categoryId: category.id))")
        #expect(localDataSource.getTodos(categoryId: category.id).first?.todo == "Todo1 Updated")
        
        // Delete Test
        try! localDataSource.deleteTodo(todoId: todo.id)
        
        print("(todo)delete test: \(localDataSource.getTodos(categoryId: category.id))")
        #expect(localDataSource.getTodos(categoryId: category.id).isEmpty)
    }
}
