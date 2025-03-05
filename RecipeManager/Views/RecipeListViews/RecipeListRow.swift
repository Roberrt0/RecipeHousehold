//
//  RecipeListRow.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 03/09/24.
//

import SwiftUI

struct RecipeListRow: View {
    
    var recipe: RecipeModel
    let color: Color
    
    init(recipe: RecipeModel) {
        let colors: [Color] = [.blue, .green, .mint, .pink, .red, .purple, .orange, .yellow, .indigo, .cyan]
        
        self.color = colors.randomElement() ?? .black
        self.recipe = recipe
    }
    
    var body: some View {
        HStack() {
            Circle().fill(color).background(color)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(recipe.name)
                    .font(.title3)
                    .bold()
                    .padding(.top, 5)
                Text("This is a brief description of the recipe describing the recipe.")
                    .foregroundStyle(.secondary)
                
                Spacer()
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 120)
    }
}

#Preview {
    RecipeListRow(recipe: RecipesMockData.getData()[0])
//        .padding()
}
