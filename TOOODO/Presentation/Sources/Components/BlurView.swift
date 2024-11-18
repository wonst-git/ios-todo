//
//  BlurView.swift
//  Presentation
//
//  Created by 노원진 on 11/14/24.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIVisualEffectView {
        return UIVisualEffectView(
            effect: UIBlurEffect(style: .systemUltraThinMaterial)
        )
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
