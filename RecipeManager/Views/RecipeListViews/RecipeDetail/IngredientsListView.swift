//
//  IngredientsListView.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 16/09/24.
//

import Foundation
import SwiftUI

struct IngredientsListView: View {
    let ingredientList: [String]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(ingredientList, id: \.self) { ingredient in
                    HStack(spacing: 15) {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 8))
                            .foregroundStyle(.teal)
                        
                        Text(ingredient)
                            .font(.body)
                            .foregroundStyle(.primary)
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color(.secondarySystemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                }
            }
            .padding()
        }
        .navigationTitle("Ingredients")
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    NavigationStack {
        IngredientsListView(ingredientList: [
            "5 cups of something",
            "2 spoons of sugar",
            "some oranges",
            "3 eggs",
            "a carton of milk",
            "5 strawberries",
            "mermelade"
        ])
    }
}
