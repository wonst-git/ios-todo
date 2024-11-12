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
    
    init(category: Domain.Category) {
        self.category = category
        
        self.count = category.todos.count
        self.completedCount = category.todos.count(where: {
            $0.completed
        })
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text(category.category)
                .font(.system(size: 44))
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .lineLimit(3)
            
            Spacer()
                .frame(height: 10)
            
            Text(category.categoryDes)
                .font(.system(size: 24))
                .fontWeight(.medium)
                .foregroundStyle(.white)
                .lineLimit(2)
            
            Spacer().frame(minHeight: 30)
            
            HStack {
                GeometryReader { chartGeo in
                    
                    ZStack(alignment: .bottom) {
                        Color.clear
                        
                        Color.white
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
                        .stroke(.white, lineWidth: 2)
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
                .foregroundStyle(.white)
                
                Spacer()
            }
            .frame(height: 80)
            
            Spacer().frame(minHeight: 30)
            
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis")
                        .frame(width: 70, height: 70)
                        .foregroundStyle(.white.opacity(0.7))
                        .background(
                            Circle().stroke(.white.opacity(0.7), lineWidth: 2)
                        )
                        .clipShape(Circle())
                }
                
                Spacer()
                
                Button {
                    print("clicked")
                } label: {
                    Image(systemName: "plus")
                        .frame(width: 70, height: 70)
                        .foregroundStyle(.black)
                        .background(.white.opacity(0.7))
                        .clipShape(Circle())
                }
            }
        }
        .padding([.horizontal, .bottom], 8)
        .padding(.top, 20)
        .background(
            ZStack {
                let color = Color.init(hex: category.color).darker()
                
                color
                
                Circle()
                    .fill(color.darker())
                    .padding(.all, 40)
                
                Circle()
                    .fill(color.darker().darker())
                    .padding(.all, 100)
            }
                .blur(radius: 8)
        )
        .clipShape(RoundedRectangle.init(cornerRadius: 30))
        .shadow(radius: 10, x: 0, y: 0)
        .padding(.horizontal, 8)
        .frame(minHeight: 400, maxHeight: .infinity)
        .onTapGesture {
            print("onTap")
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
    
    CategoryItemView(category: category)
}
