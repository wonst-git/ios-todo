//
//  BasePopup.swift
//  Presentation
//
//  Created by 노원진 on 11/14/24.
//

import SwiftUI

struct BasePopup<Content> : View where Content : View {
    @Binding private var isActive: Bool
    
    @Binding private var disabled: Bool
    
    @State private var alpha: Double = 0
    
    private let negativeText: String
    private let positiveText: String
    
    private let content: () -> Content
    private let action: () -> Void
    
    init(isActive: Binding<Bool>, disabled: Binding<Bool>, negativeText: String = "", positiveText: String = "", @ViewBuilder content: @escaping () -> Content, action: @escaping () -> Void) {
        self._isActive = isActive
        self._disabled = disabled
        self.content = content
        self.action = action
        self.negativeText = negativeText
        self.positiveText = positiveText
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.2)
                .onTapGesture {
                    close()
                }
                .ignoresSafeArea()
            
            VStack (alignment: .leading) {
                content()
                
                Spacer().frame(height: 20)

                GeometryReader { geo in
                    HStack(spacing: 0) {
                        Button {
                            close()
                        } label: {
                            Text(negativeText)
                                .frame(width: (geo.size.width / 2) - 5, height: geo.size.height)
                                .foregroundStyle(.black)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .disabled(negativeText.isEmpty)
                        
                        Spacer().frame(width: 10)
                        
                        Button {
                            action()
                            close()
                        } label: {
                            Text(positiveText)
                                .frame(width: (geo.size.width / 2) - 5, height: geo.size.height)
                                .foregroundStyle(.white)
                                .background {
                                    RoundedRectangle(cornerRadius: 10).fill(disabled ? .gray : .black)
                                }
                        }
                        .disabled(disabled)
                    }
                }.frame(height: 40)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
            .background {
                BlurView()
                    .background(.white.opacity(0.8))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .compositingGroup()
            .shadow(radius: 10)
            .padding(22)
        }
        .opacity(alpha)
        .onAppear {
            withAnimation(.smooth(duration: 0.5)) {
                alpha = 1
            }
        }
    }
    
    private func close() {
        withAnimation(.smooth(duration: 0.5)) {
            alpha = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isActive = false
        }
    }
}
