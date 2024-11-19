//
//  CreateTodoPopup.swift
//  Presentation
//
//  Created by 노원진 on 11/15/24.
//

import SwiftUI

struct CreateTodoPopup: View {
    @State private var disabled: Bool = false
    @State private var todo: String = ""
    @FocusState private var focusedField: TextFields?
    
    @Binding private var isActive: Bool
    
    private let action: (String) -> Void
    
    private enum TextFields: Hashable {
        case name
    }
    
    init (isActive: Binding<Bool>, action: @escaping (String) -> Void) {
        self._isActive = isActive
        self.action = action
    }
    
    var body: some View {
        BasePopup(isActive: $isActive, disabled: $disabled, negativeText: "Cancel", positiveText: "Create") {
            Text("Create Todo")
                .font(.title3)
                .fontWeight(.semibold)
            
            Spacer().frame(height: 10)
            
            Text("Todo Name")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(.black.opacity(0.7))
            
            TextField(todo, text: $todo)
                .padding(.horizontal, 4)
                .padding(.vertical, 6)
                .background(RoundedRectangle(cornerRadius: 8).stroke(.gray, lineWidth: 1))
                .focused($focusedField, equals: .name)
        } action: {
            action(todo)
        }
        .onAppear {
            focusedField = .name
        }

    }
}
