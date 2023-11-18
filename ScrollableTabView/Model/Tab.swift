//
//  Tab.swift
//  ScrollableTabView
//
//  Created by park kyung seok on 2023/11/18.
//

import Foundation

enum Tab: String, CaseIterable, Identifiable, Hashable {
    case chats = "Charts"
    case calls = "Calles"
    case settings = "Settings"
    
    var systemImage: String {
        switch self {
        case .calls: "phone"
        case .chats: "bubble.left.and.bubble.right"
        case .settings: "gear"
        }
    }
    
    var id: String { rawValue }
}
