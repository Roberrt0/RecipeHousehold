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
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
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
            CookingView(steps: RecipesMockData.getData()[0].steps)
        }
        .modelContainer(sharedModelContainer)
    }
}
