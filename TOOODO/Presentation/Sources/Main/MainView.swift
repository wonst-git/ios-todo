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
    @State private var opacity: CGFloat = .zero
    
    public init() { }
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            ScrollViewReader { proxy in
                GeometryReader { geo in
                    let size = geo.size
                    let safeArea = geo.safeAreaInsets
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: .zero) {
                            MainHeaderView(offsetY: $offsetY, categories: $viewModel.categories, size: size, safeArea: safeArea)
                                .zIndex(1)
                                .id("Header")
                            
                            SampleCardsView()
                            
                        }
                        .background {
                            ScrollDetector { offset in
                                let _ = print("offsetY: \(offset)")
                            } onDraggingEnd: { offset, velocity in
                                let headerHeight = size.height * 0.14 - 70
                                
                                let targetEnd = offset + (velocity * 45)
                                
                                if targetEnd < headerHeight && targetEnd > 0 {
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
            
            VStack {
                Button("UpsertTest") {
                    viewModel.upsertCategoryTest()
                }
                .background(.black)
                
                Button("DeleteTest") {
                    viewModel.deleteCategoryTest()
                    
                }
                .background(.black)
            }
        }
        .frame(maxHeight: .infinity)
    }
    
    @ViewBuilder
    func SampleCardsView() -> some View {
        LazyVStack(spacing: 10) {
            ForEach(viewModel.categories, id: \.id) { category in
                CategoryItemView(category: category)
            }
        }
        .padding([.top, .bottom], 30)
    }
    
    @ViewBuilder
    private func createCategoryFAB() -> some View {
        Button("+ Create") {
            
        }
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
