//
//  RecipeDetail2.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 01/03/26.
//

import SwiftUI

struct RecipeDetail: View {
    var recipe: RecipeModel
    @Environment(\.dismiss) private var dismiss
    
    var formattedPrepTime: String? {
        guard let prepTime = recipe.timeToPrep else { return nil }
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: prepTime)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // 1. REFINED COMPACT HEADER
            HStack(spacing: 15) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3.bold())
                        .foregroundStyle(.white)
                        .padding(10)
                        .background(.white.opacity(0.2))
                        .clipShape(Circle())
                }
                
                Text(recipe.name)
                    .font(.title2.bold())
                    .foregroundStyle(.white)
                    .lineLimit(1)
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 15)
            .padding(.top, 60) // Increase slightly for iPhone 15/16 Pro notches
            .background {
                // APPLY THE GRADIENT HERE
                LinearGradient(
                    colors: [.teal, Color(red: 0.1, green: 0.6, blue: 0.7)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea(edges: .top) // THIS is the critical line
            }
            .clipShape(UnevenRoundedRectangle(bottomLeadingRadius: 25, bottomTrailingRadius: 25))

            // 2. SCROLLVIEW CONTENT
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    // TAGS SECTION
                    if !recipe.tags.isEmpty {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Tags")
                                .font(.headline)
                                .foregroundStyle(.secondary)
                                .padding(.leading, 5)
                            TagCloudView(tags: recipe.tags)
                        }
                        .padding(.top, 20)
                    }
                    
                    threeStats
                    
                    Divider()
                    
                    someButtons
                    
                    Divider()
                    
                    if !recipe.notes.isEmpty {
                        notesSection
                    }
                    
                    Spacer(minLength: 50)
                }
                .padding(.horizontal)
                .padding(.top)
            }
        }
        .navigationBarBackButtonHidden()
        .background(Color(.systemGroupedBackground))
        .ignoresSafeArea(edges: .top) // Also add here to ensure the VStack can bleed up
    }

    
    var threeStats: some View {
        HStack {
            statItem(label: "Prep time", value: formattedPrepTime ?? "--")
            Spacer()
            statItem(label: "Ingredients", value: "\(recipe.ingredients.count)")
            Spacer()
            statItem(label: "Steps", value: "\(recipe.steps.count)")
        }
    }
    
    private func statItem(label: String, value: String) -> some View {
        VStack(spacing: 8) {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
            Text(value)
                .font(.title3)
                .bold()
        }
        .frame(maxWidth: .infinity)
    }
    
    var someButtons: some View {
        VStack(spacing: 12) {
            // Check Ingredients
            NavigationLink(destination: IngredientsListView(ingredientList: recipe.ingredients)) {
                buttonContent(title: "Check ingredients list", icon: "basket.fill", color: .teal)
            }
            
            // Review Instructions
            NavigationLink(destination: StepListView(steps: recipe.steps)) {
                buttonContent(title: "Review instructions", icon: "list.bullet.clipboard.fill", color: .teal)
            }
            
            // Start Cooking
            NavigationLink(destination: CookingView(steps: recipe.steps)) {
                HStack {
                    Text("Start cooking!")
                    Image(systemName: "cooktop.fill")
                }
                .foregroundStyle(.white)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(LinearGradient(colors: [.orange, .red], startPoint: .leading, endPoint: .trailing))
                .clipShape(Capsule())
                .shadow(color: .orange.opacity(0.3), radius: 10, y: 5)
                .padding(.top, 10)
            }
        }
    }
    
    private func buttonContent(title: String, icon: String, color: Color) -> some View {
        HStack {
            Label(title, systemImage: icon)
            Spacer()
            Image(systemName: "chevron.right").font(.caption).bold()
        }
        .foregroundStyle(.white)
        .padding()
        .background(color)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
    
    var notesSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Your notes")
                .font(.title2)
                .bold()
            Text(recipe.notes)
                .font(.body)
                .foregroundStyle(.secondary)
                .lineSpacing(4)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}


#Preview {
    NavigationStack {
        RecipeDetail(recipe: RecipesMockData.getData()[0])
    }
    .modelContainer(previewContainer)
}
