//
//  RecipesDataService.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 12/11/24.
//

import Foundation
import SwiftUI
import SwiftData


class RecipesDataService: ObservableObject {
    static func validateTitle(title: String) -> Bool {
        return title.count >= 3
    }
    
    // 🛠 Logic for the App
    static func upsert(recipe: RecipeModel, context: ModelContext) {
        print("upserting recipe...")
        context.insert(recipe) // SwiftData handles the "Update or Insert" logic automatically via @Attribute(.unique)
        try? context.save()
        DispatchQueue.global(qos: .background).async {
            MetricsService.sendEvent(.recipeCreated)
        }
        print("upsert of recipe successful!")
    }
    
    static func delete(at offsets: IndexSet, from recipes: [RecipeModel], in context: ModelContext) {
        for index in offsets {
            let recipe = recipes[index]
            context.delete(recipe)
        }
    }
    
    static func stressTestDatabase(count: Int, context: ModelContext, allTags: [TagModel]) {
        // Array of sample data to randomize from
        let sampleNames = ["Classic", "Spicy", "Homemade", "Quick", "Grandma's", "Gourmet"]
        let sampleDishes = ["Pasta", "Taco", "Salad", "Soup", "Burger", "Risotto", "Curry"]
        let sampleIngredients = ["Salt", "Pepper", "Olive Oil", "Garlic", "Onion", "Water", "Secret Sauce"]
        
        // Bulk insertion
        for i in 1...count {
            let randomName = "\(sampleNames.randomElement()!) \(sampleDishes.randomElement()!) #\(i)"
            let randomTags = allTags.isEmpty ? [] : [allTags.randomElement()!].compactMap { $0 }
            
            let newRecipe = RecipeModel(
                name: randomName,
                ingredients: sampleIngredients.shuffled().prefix(4).map { String($0) },
                steps: ["Step 1: Prep the \(randomName)", "Step 2: Cook it", "Step 3: Serve and enjoy!"],
                tags: randomTags,
                notes: "Automated stress test entry.",
                timeToPrep: TimeInterval.random(in: 300...3600)
            )
            
            context.insert(newRecipe)
        }
        
        // Final commit to disk
        try? context.save()
        
        // DevOps Tip: This is the perfect moment to ping your Flask server
        // FlaskMonitor.sendBulkMetric(count: count)
    }
}
