//
//  EditCategoryPopup.swift
//  Presentation
//
//  Created by 노원진 on 11/14/24.
//

import SwiftUI
import Domain

struct EditCategoryPopup: View {
    @Binding private var isActive: Bool
    
    @State private var categoryName: String
    @State private var categoryDes: String
    @State private var color: Optional<Int>
    
    @FocusState private var focusedField: TextFields?

    private var disabled: Binding<Bool> {
        Binding(get: {
            self.categoryName.isEmpty || self.categoryDes.isEmpty || color == nil
        }) { _ in }
    }
    
    private var action: (String, String, Int) -> ()
    
    private let colors: [Int] = [
        0xfffea3aa, 0xfff8b88b, 0xfffaf884, 0xffbaed91, 0xffb2cefe, 0xfff2a2e8
    ]
    
    private enum TextFields: Int, Hashable {
        case title, des
    }
    
    init(_ category: Domain.Category?, isActive: Binding<Bool>, action: @escaping (String, String, Int) -> Void) {
        self._isActive = isActive
        self.action = action
                
        self.categoryName = category?.category ?? ""
        self.categoryDes = category?.categoryDes ?? ""
        self.color = category?.color
    }
    
    var body: some View {
        BasePopup(isActive: $isActive, disabled: disabled, negativeText: "Cancel", positiveText: "Update") {
            Text("Modify Category")
                .font(.title3)
                .fontWeight(.semibold)
                
            Spacer().frame(height: 10)
            
            Text("Category Name")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(.black.opacity(0.7))
            
            TextField(categoryName, text: $categoryName)
                .padding(.horizontal, 4)
                .padding(.vertical, 6)
                .background(RoundedRectangle(cornerRadius: 8).stroke(.gray, lineWidth: 1))
                .focused($focusedField, equals: .title)
                
            
            Spacer().frame(height: 6)
            
            Text("Category Description")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(.black.opacity(0.7))
            
            TextField(categoryDes, text: $categoryDes)
                .padding(.horizontal, 4)
                .padding(.vertical, 6)
                .background(RoundedRectangle(cornerRadius: 8).stroke(.gray, lineWidth: 1))
                .focused($focusedField, equals: .des)
            
            Spacer().frame(height: 6)
            
            Text("Category Color")
                .font(.caption)
                .foregroundStyle(.black.opacity(0.7))
            
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(colors, id: \.self) { color in
                        Circle()
                            .fill(Color.init(hex: color))
                            .overlay{
                                if (self.color == color) {
                                    Circle().strokeBorder(.gray, lineWidth: 2)
                                }
                            }
                            .onTapGesture {
                                self.color = color
                            }
                    }
                }
                .frame(height: 32)
            }
            
            
        } action: {
            self.action(categoryName, categoryDes, color!)
        }
        .onAppear {
            focusedField = .title
        }
    }
}
