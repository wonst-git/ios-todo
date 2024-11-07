//
//  DependencyProviderExtension.swift
//  TOOODO
//
//  Created by 노원진 on 11/7/24.
//

import Swinject

class DependencyProvider {
    static let shared = DependencyProvider()
    
    private let container = Container()
    
    func register() {
        _ = Assembler(
            [
                DataSourceAssembly(),
                RepositoryAssembly(),
                UseCaseAssembly()
            ],
            container: self.container
        )
    }
}
