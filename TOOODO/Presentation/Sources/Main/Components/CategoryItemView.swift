//
//  CategoryItemView.swift
//  Presentation
//
//  Created by 노원진 on 11/12/24.
//

import SwiftUI
import Domain

struct CategoryItemView: View {
    private let category: Domain.Category
    
    private let count: Int
    private let completedCount: Int
    
    private let clickAction: (Actions) -> ()
    
    enum Actions {
        case Select, More, Add
    }
    
    init(category: Domain.Category, clickAction: @escaping (Actions) -> ()) {
        self.category = category
        
        self.count = category.todos.count
        self.completedCount = category.todos.count(where: {
            $0.completed
        })
        
        self.clickAction = clickAction
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text(category.category)
                .font(.system(size: 44))
                .fontWeight(.bold)
                .foregroundStyle(.black.opacity(0.8))
                .lineLimit(3)
            
            Spacer()
                .frame(height: 10)
            
            Text(category.categoryDes)
                .font(.system(size: 24))
                .fontWeight(.medium)
                .foregroundStyle(.black.opacity(0.8))
                .lineLimit(2)
            
            Spacer().frame(minHeight: 30)
            
            HStack {
                GeometryReader { chartGeo in
                    
                    ZStack(alignment: .bottom) {
                        Color.clear
                        
                        Color.black.opacity(0.8)
                            .frame(
                                height: count == 0
                                ? 0
                                : chartGeo.size.height * (CGFloat(completedCount) / CGFloat(count))
                            )
                    }
                }
                .frame(width: 20)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black.opacity(0.8), lineWidth: 4)
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading) {
                    Text(
                        count == 0 ? "0" : "\(completedCount) / \(count)"
                    )
                    .font(.system(size: 24))
                    .fontWeight(.medium)
                    
                    Spacer()
                    
                    Text("tasks")
                        .font(.system(size: 16))
                }
                .foregroundStyle(.black.opacity(0.8))
                
                Spacer()
            }
            .frame(height: 80)
            
            Spacer().frame(minHeight: 30)
            
            HStack {
                Button {
                    clickAction(.More)
                } label: {
                    Image(systemName: "ellipsis")
                        .frame(width: 70, height: 70)
                        .foregroundStyle(.black.opacity(0.8))
                        .background(
                            Circle().stroke(.black.opacity(0.8), lineWidth: 4)
                        )
                        .clipShape(Circle())
                }
                
                Spacer()
                
                Button {
                    clickAction(.Add)
                } label: {
                    Image(systemName: "plus")
                        .frame(width: 70, height: 70)
                        .foregroundStyle(.white)
                        .background(.black.opacity(0.6))
                        .clipShape(Circle())
                }
            }
        }
        .padding([.horizontal, .bottom], 8)
        .padding(.top, 20)
        .background {
            BlurView()
                .background {
                    let color = Color.init(hex: category.color)

                    RadialGradient(colors: [color.darker(by: 10), color.opacity(0.2)], center: .center, startRadius: 20, endRadius: 200)
                }
        }
        .clipShape(RoundedRectangle.init(cornerRadius: 30))
        .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 0)
        .padding(.horizontal, 8)
        .frame(minHeight: 400, maxHeight: .infinity)
        .onTapGesture {
            clickAction(.Select)
        }
    }
}


#Preview {
    let category = Domain.Category(
        id: "",
        category: "Holidays in Norway",
        categoryDes: "",
        color: 0xff22aadd,
        todos: []
    )
    
    CategoryItemView(category: category) {
        switch($0) {
        case .Select:
            break
        case .Add:
            break
        case .More:
            break
        }
    }

}
