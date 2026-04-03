//
//  RecipeManagerApp.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 30/08/24.
//

import SwiftUI
import SwiftData

@main
struct RecipeManagerApp: App {
    
    // This container manages the database file on the device
       var sharedModelContainer: ModelContainer = {
           let schema = Schema([
               RecipeModel.self,
               TagModel.self,
           ])
           let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

           do {
               return try ModelContainer(for: schema, configurations: [modelConfiguration])
           } catch {
               fatalError("Could not create ModelContainer: \(error)")
           }
       }()

    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(sharedModelContainer)
    }
}

@MainActor
let previewContainer: ModelContainer = {
    let schema = Schema([RecipeModel.self, TagModel.self])
    
    // Persistance is disabled for this container
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    
    do {
        let container = try ModelContainer(for: schema, configurations: [config])
        
        // Insert mock data
        let tagsMockData = TagsMockData.getData()
        for tag in tagsMockData {
            container.mainContext.insert(tag)
        }
        
        // 1. Classic Butter Cookies (Replacing DevOps Cookies)
        let butterCookies = RecipeModel(
            name: "Classic Butter Cookies",
            ingredients: ["1 cup butter, softened", "1/2 cup sugar", "2 cups all-purpose flour", "1 tsp vanilla extract"],
            steps: ["Cream butter and sugar until fluffy", "Stir in vanilla and flour until dough forms", "Chill dough for 30 mins", "Roll and cut into shapes", "Bake at 350°F for 10-12 mins"],
            tags: [tagsMockData.randomElement()!],
            notes: "A simple, melt-in-your-mouth shortbread style cookie.",
            timeToPrep: 2700) // 45 mins
        container.mainContext.insert(butterCookies)

        // 2. Quick Pasta Carbonara
        let carbonara = RecipeModel(
            name: "Classic Pasta Carbonara",
            ingredients: ["1 lb spaghetti", "4 large eggs", "1 cup Pecorino Romano", "8 oz pancetta or guanciale", "Black pepper"],
            steps: ["Boil pasta in salted water", "Fry pancetta until crispy", "Whisk eggs and cheese in a bowl", "Toss hot pasta with pancetta", "Remove from heat and stir in egg mixture quickly"],
            tags: [tagsMockData.randomElement()!],
            notes: "Do not add the eggs while the pan is on the heat or they will scramble!",
            timeToPrep: 1200) // 20 mins
        container.mainContext.insert(carbonara)

        // 3. Street-Style Chicken Tacos
        let chickenTacos = RecipeModel(
            name: "Chicken Street Tacos",
            ingredients: ["1.5 lbs chicken thighs", "12 corn tortillas", "1 lime", "Cilantro", "White onion", "Taco seasoning"],
            steps: ["Season and grill chicken until cooked through", "Dice chicken into small cubes", "Warm tortillas on a skillet", "Top with onions, cilantro, and a squeeze of lime"],
            tags: [tagsMockData.randomElement()!],
            notes: "Best served with a side of salsa verde.",
            timeToPrep: 1800) // 30 mins
        container.mainContext.insert(chickenTacos)

        // 4. Fresh Greek Salad
        let greekSalad = RecipeModel(
            name: "Fresh Greek Salad",
            ingredients: ["1 English cucumber", "4 Roma tomatoes", "1/2 red onion", "1/2 cup Kalamata olives", "4 oz Feta cheese", "Olive oil & Oregano"],
            steps: ["Chop cucumber, tomatoes, and onion into large chunks", "Combine in a bowl with olives", "Top with a large slice of feta", "Drizzle with olive oil and sprinkle with oregano"],
            tags: [tagsMockData.randomElement()!],
            notes: "Traditional Greek salad does not use lettuce!",
            timeToPrep: 600) // 10 mins
        container.mainContext.insert(greekSalad)

        // 5. Margherita Pizza
        let margheritaPizza = RecipeModel(
            name: "Margherita Pizza",
            ingredients: ["Pizza dough", "San Marzano tomatoes", "Fresh mozzarella", "Fresh basil", "Extra virgin olive oil"],
            steps: ["Stretch dough onto a pizza stone", "Spread crushed tomatoes thinly", "Top with mozzarella slices", "Bake at 500°F until charred", "Add fresh basil and oil after baking"],
            tags: [tagsMockData.randomElement()!],
            notes: "High heat is the secret to a crispy crust.",
            timeToPrep: 3600) // 60 mins (includes dough rise)
        container.mainContext.insert(margheritaPizza)

        
        return container
    } catch {
        fatalError("Failed to create preview container")
    }
}()

@MainActor
let previewContainer2: ModelContainer = {
    let schema = Schema([RecipeModel.self, TagModel.self])
    
    // Persistance is disabled for this container
    let config = ModelConfiguration(isStoredInMemoryOnly: false)
    
    do {
        let container = try ModelContainer(for: schema, configurations: [config])
        
        return container
    } catch {
        fatalError("Failed to create preview container")
    }
}()
