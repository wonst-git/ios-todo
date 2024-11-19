//
//  BaseBottomSheet.swift
//  Presentation
//
//  Created by 노원진 on 11/15/24.
//

import SwiftUI

struct BaseBottomSheet<Content>: View where Content: View {
    
    @Binding private var isPresented: Bool
    @State private var animationState: CGFloat = .zero
    
    @State private var height: CGFloat = .zero
    private var content: (@escaping () async -> Void) -> Content
    
    init(isPresented: Binding<Bool>, height: CGFloat, @ViewBuilder content: @escaping (@escaping () async -> Void) -> Content) {
        self._isPresented = isPresented
        self.content = content
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    
                }
            
            VStack {
                Spacer()
                    .frame(maxWidth: .infinity, maxHeight: 10)
                
                RoundedRectangle(cornerRadius: 100)
                    .foregroundColor(.gray)
                    .frame(width: 30, height: 5)
                
                Spacer()
                    .frame(maxWidth: .infinity, maxHeight: 20)
                
                self.content(self.close)
            }
            .background {
                RadiusShape(topRadius: 30, bottomRadius: 0)
                    .fill(.white)
                    .ignoresSafeArea()

                GeometryReader { proxy in
                    Color.clear
                        .preference(key: ViewHeightPreferencesKey.self, value: proxy.size.height)
                }
            }
            .offset(y: height - animationState)
            .gesture(
                DragGesture()
                    .onChanged{ value in
                        if 0 <= value.translation.height {
                            let translation = min(self.height, max(-self.height, value.translation.height))
                            
                            animationState = height - translation
                        }
                    }
                    .onEnded { value in
                        if value.translation.height >= height / 2 {
                            Task {
                                await close()
                            }
                        } else {
                            open()
                        }
                    }
            )
        }
        .opacity(animationState / height)
        .onAppear {
            open()
        }
        .onPreferenceChange(ViewHeightPreferencesKey.self) { value in
            height = value
        }
    }
    
    private func open() {
        withAnimation(.smooth(duration: 0.4)) {
            animationState = height
        }
    }
    
    private func close() async {
        withAnimation(.smooth(duration: 0.4)) {
            animationState = 0
        }
        
        try? await Task.sleep(nanoseconds: 400_000_000)

        isPresented = false
    }
}

private class ViewHeightPreferencesKey: PreferenceKey {
    static var defaultValue: CGFloat { .zero }
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
