//
//  Home.swift
//  ScrollableTabView
//
//  Created by park kyung seok on 2023/11/18.
//

import SwiftUI

struct Home: View {
    
    @State private var selectedTab: Tab?
    @Environment(\.colorScheme) var scheme
    @State private var tabProgress: CGFloat = 0
    
    var body: some View {
        
        VStack(spacing: 15) {
            header
            
            TabBar()
            
            GeometryReader {
                // 親のsizeを取得
                let size = $0.size
                
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 0) {
                        CardView(color: .purple)
                            .id(Tab.chats)
                            .containerRelativeFrame(.horizontal)
                        
                        CardView(color: .red)
                            .id(Tab.calls)
                            .containerRelativeFrame(.horizontal)
                        
                        CardView(color: .blue)
                            .id(Tab.settings)
                            .containerRelativeFrame(.horizontal)
                    }
                    .offsetX { value in
                                                
                        // 0, 1, 2
                        let progress = -value / size.width
                        // scrollで 左、右端にはみ出ないように min , maxで制御
                        tabProgress = max(0, min(progress, 2))
                    }
                }
                .scrollPosition(id: $selectedTab)
                .scrollClipDisabled()
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.paging)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(.gray.opacity(0.1))
       
    }
    
    @ViewBuilder
    func TabBar() -> some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases) { tab in
                HStack(spacing: 10) {
                    Image(systemName: tab.systemImage)
                    
                    Text(tab.rawValue)
                        .font(.callout)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .contentShape(.capsule)
                .onTapGesture {
                    withAnimation(.snappy) {
                        selectedTab = tab
                    }
                }
            }
        }
        .tabMask(tabProgress: self.tabProgress)
        .background(
            GeometryReader {
                
                // paddingが除外された 親のsize
                let size = $0.size
                let capsuleWidth = size.width / CGFloat(Tab.allCases.count)
                
                Capsule()
                    .fill(.white)
                    .frame(width: capsuleWidth)
                    .offset(x: tabProgress * capsuleWidth)
            }
        )
        .background(.gray.opacity(0.1), in: .capsule)
        .padding(.horizontal, 15)
    }
    
    @ViewBuilder
    func CardView(color: Color) -> some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 2), content: {
                ForEach(1...10, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 12)
                        .fill(color.gradient)
                        .frame(height: 150)
                        .overlay {
                            VStack(alignment: .leading) {
                                Circle()
                                    .fill(.white.opacity(0.2))
                                    .frame(width: 50, height: 50)
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(.white.opacity(0.3))
                                        .frame(width: 80, height: 9)
                                    
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(.white.opacity(0.3))
                                        .frame(width: 60, height: 9)
                                    
                                    Spacer()
                                    
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(.white.opacity(0.3))
                                        .frame(width: 40, height: 9)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                }
            })
            .padding()
        }
        .scrollIndicators(.hidden)
        .scrollClipDisabled()
        .mask {
            Rectangle()
                .padding(.bottom, -100)
        }
    }
}

extension Home {
    var header: some View {
        HStack {
            Button {
                
            } label: {
                Image(systemName: "line.3.horizontal.decrease")
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "bell.badge")
            }
        }
        .font(.title2)
        .overlay {
            Text("Messages")
                .font(.title3.bold())
        }
        .foregroundStyle(.primary)
        .padding()
    }
}

#Preview {
    Home()
}
