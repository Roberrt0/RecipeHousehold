//
//  RecipeListRow.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 03/09/24.
//

import SwiftUI

struct RecipeListRow: View {
    let recipe: RecipeModel
    let themeColor: Color
    
    init(recipe: RecipeModel) {
        self.recipe = recipe
        // Stable color based on hash so it's consistent for testing
        let colors: [Color] = [.orange, .red, .teal, .green, .indigo, .pink, .purple, .blue]
        let index = abs(recipe.name.hashValue % colors.count)
        self.themeColor = colors[index]
    }
    
    // Smart icon mapping based on keywords
    var recipeIcon: String {
        let name = recipe.name.lowercased()
        if name.contains("cake") || name.contains("dessert") || name.contains("sweet") { return "birthday.cake.fill" }
        if name.contains("coffee") || name.contains("tea") || name.contains("drink") { return "cup.and.saucer.fill" }
        if name.contains("pasta") || name.contains("spaghetti") || name.contains("noodle") { return "fork.knife" }
        if name.contains("salad") || name.contains("healthy") || name.contains("leaf") { return "leaf.fill" }
        if name.contains("meat") || name.contains("steak") || name.contains("chicken") { return "flame.fill" }
        if name.contains("fish") || name.contains("sea") { return "fish.fill" }
        if name.contains("bread") || name.contains("toast") || name.contains("bake") { return "square.grid.3x3.fill" }
        if name.contains("pizza") { return "circle.grid.3x3.fill" }
        return "fork.knife.circle.fill" // Default
    }
    
    var formattedPrepTime: String? {
        guard let prepTime = recipe.timeToPrep else { return nil }
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: prepTime).map { " • \($0)" }
    }
    
    var body: some View {
        HStack(spacing: 16) {
            // 1. SMART ICON (Looks like a Recipe Card)
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(themeColor.gradient)
                    .frame(width: 54, height: 54)
                
                Image(systemName: recipeIcon)
                    .font(.title2)
                    .foregroundStyle(.white)
                    .shadow(radius: 1)
            }
            
            // 2. INFO SECTION
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                Text("\(recipe.ingredients.count) ingredients • \(recipe.steps.count) steps \(formattedPrepTime ?? "")")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                // 3. MINI TAG INDICATORS
                if !recipe.tags.isEmpty {
                    HStack(spacing: 4) {
                        ForEach(recipe.tags.prefix(5)) { tag in
                            Circle()
                                .fill(tag.swiftUIColor)
                                .frame(width: 8, height: 8)
                        }
                    }
                    .padding(.top, 2)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 6)
    }
}




#Preview {
    RecipeListRow(recipe: RecipesMockData.getData()[0])
//        .padding()
}
