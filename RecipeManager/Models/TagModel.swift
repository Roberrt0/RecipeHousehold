//
//  TagModel.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 14/09/24.
//

import SwiftUI

struct TagModel: Identifiable, Equatable {
    let id: String
    let title: String
    let colorName: String
    let isSelected: Bool = false
    
    init(id: String = UUID().uuidString, title: String, colorName: String) {
        self.id = id
        self.title = title
        self.colorName = colorName
    }
    
    func getColor() -> Color {
        switch colorName {
        case "blue": return Color.blue
        case "green": return Color.green
        case "yellow": return Color.yellow
        case "red": return Color.red
        case "purple": return Color.purple
        case "mint": return Color.mint
        case "indigo": return Color.indigo
        case "orange": return Color.indigo
        default: return Color.black
        }
    }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}


struct TagsMockData {
    static func getData() -> [TagModel] {
        let data: [TagModel] = [
            .init(title: "High in calories", colorName: "red"),
            .init(title: "Sweeties", colorName: "red"),
            .init(title: "Gluten free", colorName: "blue"),
            .init(title: "5 Servings", colorName: "purple"),
            .init(title: "Delicious", colorName: "mint"),
            .init(title: "Healthy", colorName: "green")
        ]
        return data
    }
    
}
