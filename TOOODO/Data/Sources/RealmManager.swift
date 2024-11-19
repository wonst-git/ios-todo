//
//  RealmManager.swift
//  Data
//
//  Created by 노원진 on 11/19/24.
//

import RealmSwift
import Combine

public class RealmManager {
    typealias Configuration<Element> = (Results<Element>) -> Results<Element> where Element: RealmFetchable
    
    private let realm: Realm = try! Realm()
    
    func getPublisher<Element: RealmFetchable>(_ type: Element.Type, configuration: Configuration<Element> = { $0 }) -> AnyPublisher<Array<Element>, Error> {
        let results = realm.objects(type)
        
        return configuration(results)
            .collectionPublisher
            .map { Array($0) }
            .eraseToAnyPublisher()
    }
    
    func get<Element: RealmFetchable>(_ type: Element.Type, configuration: Configuration<Element> = { $0 }) -> Array<Element> {
        let results = realm.objects(type)
        
        return Array(configuration(results))
    }
    
    func upsert(_ object: Object) throws {
        try realm.write {
            realm.add(object, update: .modified)
        }
    }
    
    func delete(_ object: Object) throws {
        try realm.write {
            realm.delete(object)
        }
    }
}


extension Results {
    func options() -> Results {
        return self
    }
}
