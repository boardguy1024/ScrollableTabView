//
//  View+Extensions.swift
//  ScrollableTabView
//
//  Created by park kyung seok on 2023/11/18.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

extension View {
    
    @ViewBuilder
    func offsetX(completion: @escaping (CGFloat) -> Void) -> some View {
        
        self
            .overlay {
                GeometryReader {
                    // namedを使って特定のScrollViewを指定することもできる
                    let minX = $0.frame(in: .scrollView(axis: .horizontal)).minX
                    
                    Color.clear
                        .preference(key: OffsetKey.self, value: minX)
                        .onPreferenceChange(OffsetKey.self, perform: completion)
                }
            }
    }
}
