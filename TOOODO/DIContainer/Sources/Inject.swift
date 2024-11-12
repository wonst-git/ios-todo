//
//  Inject.swift
//  DIContainer
//
//  Created by 노원진 on 11/11/24.
//

@propertyWrapper
public struct Inject<T> {
    public let wrappedValue: T = {
        if let value = DependencyProvider.shared.container.resolve(T.self) {
            return value
        } else {
            fatalError("Injection Error(\(T.self))")
        }
    }()
    
    public init() { }
}
