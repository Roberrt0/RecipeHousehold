//
//  IngredientsListView.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 16/09/24.
//

import Foundation
import SwiftUI

struct IngredientsListView: View {
    
    @State var ingredientList: [IngredientModel] = [
        .init(name: "5 cups of something"),
        .init(name: "2 spoons of sugar"),
        .init(name: "some oranges"),
        .init(name: "3 eggs"),
        .init(name: "a carton of milk"),
        .init(name: "5 strawberries"),
        .init(name: "mermelade")
    ]
    
    var body: some View {
        List {
            ForEach(ingredientList) { ingredient in
                HStack {
                    Image(systemName: ingredient.isAvailable ? "checkmark.square.fill" : "square")
                        .foregroundStyle(.yellow)
                    Text(ingredient.name)
                }
                .onTapGesture { updateIngredient(ingredient) }
            }
            .onMove(perform: { indices, newOffset in
                ingredientList.move(fromOffsets: indices, toOffset: newOffset)
            })
        }
        .navigationTitle("Ingredient List")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
        }
        
    }
    
    func updateIngredient(_ ingredient: IngredientModel) {
        if let index = ingredientList.firstIndex(where: {$0.id == ingredient.id}) {
            ingredientList[index] = ingredient.updateIngredient()
        }
    }
    
}

#Preview {
    NavigationStack {
        IngredientsListView()
    }
}
