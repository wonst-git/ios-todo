//
//  ScrollDetector.swift
//  Presentation
//
//  Created by 노원진 on 11/8/24.
//

import SwiftUI

struct ScrollDetector: UIViewRepresentable {
    var onDraggingEnd: (CGFloat) -> ()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async {
            if let scrollView = uiView.superview?.superview?.superview as? UIScrollView, !context.coordinator.isDelegateAdded {
                scrollView.delegate = context.coordinator
                context.coordinator.isDelegateAdded = true
            }
        }
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: ScrollDetector
        
        init(parent: ScrollDetector) {
            self.parent = parent
        }
        
        var isDelegateAdded: Bool = false
        
        func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            parent.onDraggingEnd(targetContentOffset.pointee.y)
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            parent.onDraggingEnd(scrollView.contentOffset.y)
        }
    }
}
