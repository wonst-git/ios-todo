//
//  RoundedShape.swift
//  Presentation
//
//  Created by 노원진 on 11/18/24.
//

import SwiftUI

struct RadiusShape: Shape {
    let topLeftRadius: CGFloat
    let topRightRadius: CGFloat
    let bottomLeftRadius: CGFloat
    let bottomRightRadius: CGFloat
    
    init(topLeftRadius: CGFloat, topRightRadius: CGFloat, bottomLeftRadius: CGFloat, bottomRightRadius: CGFloat) {
        self.topLeftRadius = topLeftRadius
        self.topRightRadius = topRightRadius
        self.bottomLeftRadius = bottomLeftRadius
        self.bottomRightRadius = bottomRightRadius
    }
    
    init(topRadius: CGFloat, bottomRadius: CGFloat) {
        self.topLeftRadius = topRadius
        self.topRightRadius = topRadius
        self.bottomLeftRadius = bottomRadius
        self.bottomRightRadius = bottomRadius
    }
    
    init(radius: CGFloat) {
        self.topLeftRadius = radius
        self.topRightRadius = radius
        self.bottomLeftRadius = radius
        self.bottomRightRadius = radius
    }
    
    nonisolated func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: .init(x: 0, y: topLeftRadius))
        
        path.addArc(center: .init(x: topLeftRadius, y: topLeftRadius), radius: topLeftRadius, startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)
        
        path.addLine(to: .init(x: rect.width - topRightRadius, y: 0))
        
        path.addArc(center: .init(x: rect.width - topRightRadius, y: topRightRadius), radius: topRightRadius, startAngle: .degrees(270), endAngle: .degrees(0), clockwise: false)
        
        path.addLine(to: .init(x: rect.width, y: rect.height - bottomRightRadius))
        
        path.addArc(center: .init(x: rect.width - bottomRightRadius, y: rect.height - bottomRightRadius), radius: bottomRightRadius, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
        
        path.addLine(to: .init(x: bottomLeftRadius, y: rect.height))
        
        path.addArc(center: .init(x: bottomLeftRadius, y: rect.height - bottomLeftRadius), radius: bottomLeftRadius, startAngle: .degrees(90), endAngle: .degrees(180), clockwise: false)
        
        path.addLine(to: .init(x: 0, y: topLeftRadius))
        
        return path
    }
}
