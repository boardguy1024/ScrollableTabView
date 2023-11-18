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
    
    
    
    @ViewBuilder
    func tabMask(tabProgress: CGFloat) -> some View {
        
        // Viewが 2層になっていて、
        // layer-0は grayで塗りつぶす
        // layer-1は capcule部分に maskをかけて currentのように見せる
        ZStack {
            self
                .foregroundStyle(.gray)
            
            self
                .symbolVariant(/*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/) // symbolを fillにする ViewModifier
                .mask {
                    GeometryReader {
                        // paddingが除外された 親のsize
                        let size = $0.size
                        let capsuleWidth = size.width / CGFloat(Tab.allCases.count)
                        
                        Capsule()
                            .fill()
                            .frame(width: capsuleWidth)
                            .offset(x: tabProgress * capsuleWidth)
                    }
                }
        }
    }
}

#Preview {
    Home()
}


