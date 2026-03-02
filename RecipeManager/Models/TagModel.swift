//
//  TagModel.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 14/09/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
final class TagModel {
    @Attribute(.unique) var id: String
    var title: String
    var color: TagColor
    var isSelected: Bool = false
    
    // Reference back to the recipes using this tag
    var recipes: [RecipeModel] = []

    init(id: String = UUID().uuidString, title: String, color: TagColor) {
        self.id = id
        self.title = title
        self.color = color
    }
    
    // Computed property for UI usage (Not stored in DB)
    @Transient
    var swiftUIColor: Color {
        return color.swiftUIColor
    }
}

enum TagColor: String, Codable, CaseIterable {
    case blue, green, yellow, red, purple, mint, indigo, orange
    
    var swiftUIColor: Color {
        switch self {
            case .blue: return .blue
            case .green: return .green
            case .yellow: return .yellow
            case .red: return .red
            case .purple: return .purple
            case .mint: return .mint
            case .indigo: return .indigo
            case .orange: return .orange
        }
    }
}

struct TagsMockData {
    static func getData() -> [TagModel] {
        let data: [TagModel] = [
            .init(title: "High in calories", color: TagColor.red),
            .init(title: "Sweeties", color: TagColor.red),
            .init(title: "Gluten free", color: TagColor.blue),
            .init(title: "5 Servings", color: TagColor.purple),
            .init(title: "Delicious", color: TagColor.mint),
            .init(title: "Healthy", color: TagColor.green)
        ]
        return data
    }
    
}
