//
//  View + Ext.swift
//  Presentation
//
//  Created by 노원진 on 11/12/24.
//

import SwiftUI

extension View {
    func apply<V: View>(@ViewBuilder _ block: (Self) -> V) -> V { block(self) }
}
