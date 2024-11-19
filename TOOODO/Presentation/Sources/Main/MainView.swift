//
//  MainView.swift
//  Presentation
//
//  Created by 노원진 on 11/8/24.
//

import SwiftUI
import Domain

public struct MainView: View {
    @StateObject private var viewModel: MainViewModel = MainViewModel()
    @State private var offsetY: CGFloat = .zero
    @State private var presentPopup: Popup? = nil
    @State private var category: Domain.Category?
    
    public init() { }
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            ScrollViewReader { proxy in
                GeometryReader { geo in
                    let size = geo.size
                    let safeArea = geo.safeAreaInsets
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: .zero) {
                            MainHeaderView(offsetY: $offsetY, categoriesCount: viewModel.categories.count, size: size, safeArea: safeArea)
                                .zIndex(1)
                                .id("Header")
                            
                            CategoryViews()
                            
                        }
                        .background {
                            ScrollDetector { offset in
                                let headerHeight = size.height * 0.14 - 70
                                
                                if offset < headerHeight && offset > 0 {
                                    withAnimation(.interactiveSpring(response: 0.55, dampingFraction: 0.65, blendDuration: 0.65)) {
                                        proxy.scrollTo("Header", anchor: .top)
                                    }
                                }
                            }
                            GeometryReader { geo in
                                Color.clear
                                    .preference(key: ScrollOffsetPreferenceKey.self, value: geo.frame(in: .global).minY)
                            }
                        }
                    }
                    .ignoresSafeArea()
                    .onPreferenceChange(ScrollOffsetPreferenceKey.self) {
                        offsetY = -$0
                    }
                }
            }
            
            Button("+ Create") {
                presentPopup = .createCategory
            }
            .padding(.all, 10)
            .background(
                BlurView()
                    .background(.white.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .black.opacity(0.2), radius: 10)
            )
            .foregroundStyle(.black)
            
            popupViews()
        }
        .frame(maxHeight: .infinity)
    }
    
    @ViewBuilder
    func CategoryViews() -> some View {
        LazyVStack(spacing: 10) {
            ForEach(viewModel.categories, id: \.id) { category in
                CategoryItemView(category: category) {
                    self.category = category
                    
                    switch($0) {
                    case .Select:
                        break
                    case .Add:
                        presentPopup = .createTodo
                        
                        break
                    case .More:
                        presentPopup = .moreBottomSheet
                        
                        break
                    }
                }
            }
        }
        .padding([.top, .bottom], 30)
    }
}

//MARK: PopupViews
extension MainView {
    
    @ViewBuilder
    private func popupViews() -> some View {
        switch presentPopup {
        case .createCategory:
            CreateCategoryPopup(
                isActive: Binding(
                    get: {
                        presentPopup == .createCategory
                    },
                    set: { _ in
                        presentPopup = nil
                    }
                )) { title, des, color in
                    viewModel.upsertCategory(id: nil, title: title, des: des, color: color)
                }
        case .modifyCategory:
            EditCategoryPopup(
                category,
                isActive: Binding(
                    get: {
                        presentPopup == .modifyCategory
                    },
                    set: { _ in
                        presentPopup = nil
                    }
                )) { title, des, color in
                    viewModel.upsertCategory(id: category?.id, title: title, des: des, color: color)
                }
        case .createTodo:
            CreateTodoPopup(
                isActive: Binding(
                    get: {
                        presentPopup == .createTodo
                    },
                    set: { _ in
                        presentPopup = nil
                    }
                )
            ) { todoName in
                viewModel.upsertTodo(categoryId: category?.id ?? "", todoName: todoName)
            }
        case .moreBottomSheet:
            BaseBottomSheet(
                isPresented: Binding(
                    get: {
                        presentPopup == .moreBottomSheet
                    },
                    set: { _ in
                        presentPopup = nil
                    }
                ), height: 100
            ) { close in
                Button {
                    Task {
                        await close()
                        presentPopup = .modifyCategory
                    }
                } label: {
                    HStack {
                        Image(systemName: "pencil")
                        Text("Edit")
                            .font(.title3)
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity)
                    
                }
                .foregroundStyle(.black)
                
                Divider()
                
                Button {
                    Task {
                        await close()
                        
                        if let category = category {
                            viewModel.deleteCategory(category: category)
                        }
                    }
                } label: {
                    HStack {
                        Image(systemName: "trash")
                        Text("Delete")
                            .font(.title3)
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity)
                }
                .foregroundStyle(.red.darker(by: 30))
            }
            
        case .none:
            EmptyView()
        }
    }
    
    private enum Popup {
        case createCategory, modifyCategory, moreBottomSheet, createTodo
    }
}

#Preview {
    MainView()
}

private struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat { .zero }
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
