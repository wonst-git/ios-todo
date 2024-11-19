//
//  Color + Ext.swift
//  Presentation
//
//  Created by 노원진 on 11/12/24.
//

import SwiftUI

extension Color {
    init(hex: Int) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255.0,
            green: Double((hex >> 08) & 0xff) / 255.0,
            blue: Double((hex >> 00) & 0xff) / 255.0,
            opacity: Double((hex >> 24) & 0xff) / 255.0
        )
    }
    
    func lighter(by percentage: CGFloat = 20.0) -> Color {
        return adjust(by: abs(percentage))
    }
    
    func darker(by percentage: CGFloat = 20.0) -> Color {
        return adjust(by: -abs(percentage))
    }
    
    private func adjust(by percentage: CGFloat = 10.0) -> Color {
        var alpha, hue, saturation, brightness, red, green, blue, white: CGFloat
        
        (alpha, hue, saturation, brightness, red, green, blue, white) = (.zero, .zero, .zero, .zero, .zero, .zero, .zero, .zero)
        
        let multiplier = percentage / 100.0
        
        let color = UIColor(self)
        
        if color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            let newBrightness: CGFloat = max(min(brightness + multiplier * brightness, 1.0), 0.0)
            
            return .init(hue: hue, saturation: saturation, brightness: newBrightness, opacity: alpha)
        } else if color.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            let newRed = min(max(red + multiplier * red, 0.0), 1.0)
            let newGreen = min(max(green + multiplier * green, 0.0), 1.0)
            let newBlue = min(max(blue + multiplier * blue, 0.0), 1.0)

            return .init(red: newRed, green: newGreen, blue: newBlue, opacity: alpha)
        } else if color.getWhite(&white, alpha: &alpha) {
            let newWhite = CGFloat(white + multiplier * white)
            
            return .init(white: newWhite, opacity: alpha)
        }
        
        return self
    }
}
