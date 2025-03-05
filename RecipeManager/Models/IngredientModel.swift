//
//  IngredientModel.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 16/09/24.
//

import Foundation

struct IngredientModel: Identifiable {
    let id: String
    var name: String
    let isAvailable: Bool
    
    init(id: String = UUID().uuidString, name: String, isAvailable: Bool = false) {
        self.id = id
        self.name = name
        self.isAvailable = isAvailable
    }
    
    func updateIngredient() -> IngredientModel {
        return IngredientModel(id: id, name: name, isAvailable: !isAvailable)
    }
}

struct IngredientsMockData {
    static func getData() -> [IngredientModel] {
        let ingredients: [IngredientModel] = [
            .init(name: "5 cups of something"),
            .init(name: "2 spoons of sugar"),
            .init(name: "some oranges"),
            .init(name: "3 eggs"),
            .init(name: "a carton of milk"),
            .init(name: "5 strawberries"),
            .init(name: "mermelade")
        ]
        
        return ingredients
    }
    
}
