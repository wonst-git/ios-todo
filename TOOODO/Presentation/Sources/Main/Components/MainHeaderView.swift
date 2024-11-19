//
//  MainHeaderView.swift
//  Presentation
//
//  Created by 노원진 on 11/11/24.
//

import SwiftUI
import Domain

struct MainHeaderView: View {
    @State private var firstTextRect: CGRect = .zero
    @State private var secondTextRect: CGRect = .zero
    @State private var imageRect: CGRect = .zero
    @State private var headerRect: CGRect = .zero
    
    @Binding private var offsetY: CGFloat
    private var categoriesCount: Int
    
    private let size: CGSize
    private let parentSafeArea: EdgeInsets
        
    init(offsetY: Binding<CGFloat>, categoriesCount: Int, size: CGSize, safeArea: EdgeInsets) {
        self._offsetY = offsetY
        self.categoriesCount = categoriesCount
        self.size = size
        self.parentSafeArea = safeArea
    }
    
    var body: some View {
        let headerHeight = size.height * 0.14 + parentSafeArea.top
        let minimumHeaderHeight: CGFloat = 70 + parentSafeArea.top
        
        let progress = max(min(offsetY / (headerHeight - minimumHeaderHeight), 1), 0)
        
        GeometryReader { _ in
            ZStack {
                Color.white
                
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Your")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .overlay {
                                GeometryReader { geo in
                                    Color.clear
                                        .onAppear() {
                                            firstTextRect = geo.frame(in: .global)
                                            
                                        }
                                }
                            }
                            .scaleEffect(1 - (progress * 0.2), anchor: .leading)
                            .offset(y: (headerRect.midY - firstTextRect.midY) * progress)
                        Text("Projects (\(categoriesCount))")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .overlay {
                                GeometryReader { geo in
                                    Color.clear
                                        .onAppear() {
                                            secondTextRect = geo.frame(in: .global)
                                        }
                                }
                            }
                            .scaleEffect(1 - (progress * 0.2), anchor: .leading)
                            .offset(x: 56 * progress)
                            .offset(y: (headerRect.midY - secondTextRect.midY) * progress)
                    }
                    
                    Spacer()
                    
                    Image("person")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: headerRect.height, height: headerRect.height)
                        .background(.gray.opacity(0.4))
                        .overlay {
                            GeometryReader { geo in
                                Circle().stroke(Color.gray)
                                    .onAppear {
                                        imageRect = geo.frame(in: .global)
                                    }
                            }
                        }
                        .clipShape(Circle())
                        .scaleEffect(1 - progress * 0.40, anchor: .trailing)
                        .offset(y: (headerRect.midY - imageRect.midY) * progress)
                }
                .frame(height: .maximum(headerHeight - offsetY, minimumHeaderHeight) * 0.5)
                .padding(.bottom, 10)
                .overlay {
                    GeometryReader { geo in
                        Color.clear
                            .onAppear() {
                                headerRect = geo.frame(in: .global)
                            }
                    }
                }
                .padding([.leading, .trailing], 16)
                .padding(.top, parentSafeArea.top)
            }
            .frame(height: .maximum(headerHeight - offsetY, minimumHeaderHeight), alignment: .bottom)
            .offset(y: offsetY)
        }
        .frame(height: headerHeight)
    }
}

#Preview{
    MainView()
}
