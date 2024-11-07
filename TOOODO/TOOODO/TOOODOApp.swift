//
//  TOOODOApp.swift
//  TOOODO
//
//  Created by 노원진 on 11/5/24.
//

import SwiftUI
import Presentation
import Data

@main
struct TOOODOApp: App {
    init() {
        DependencyProvider.shared.register()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
