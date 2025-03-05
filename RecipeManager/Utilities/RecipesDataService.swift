//
//  RecipesDataService.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 12/11/24.
//

import Foundation

class RecipesDataService {
    
    @Published var recipes: [RecipeModel] = []
    
    static let shared = RecipesDataService()
    
    private init() {
        recipes = RecipesMockData.getData()
    }
    
    func add(recipe: RecipeModel) {
        recipes.append(recipe)
    }
    
    func move(from offsets: IndexSet, to index: Int) {
        recipes.move(fromOffsets: offsets, toOffset: index)
    }
    
    func delete(at offsets: IndexSet) {
        recipes.remove(atOffsets: offsets)
    }
}
