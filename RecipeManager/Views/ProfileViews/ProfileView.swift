//
//  ProfileView.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 01/09/24.
//

import SwiftUI
import SwiftData

enum ChefLevel: String, CaseIterable {
    case novice = "Novice Cook"      // 0-10
    case homeCook = "Home Cook"      // 11-50
    case sousChef = "Sous Chef"      // 51-200
    case headChef = "Head Chef"      // 201-499
    case starChef = "Star Chef"      // 500+
    
    var color: Color {
        switch self {
        case .novice: return .gray
        case .homeCook: return .green
        case .sousChef: return .blue
        case .headChef: return .purple
        case .starChef: return .orange
        }
    }
    
    var icon: String {
        switch self {
        case .novice: return "leaf.fill"
        case .homeCook: return "frying.pan.fill"
        case .sousChef: return "fork.knife"
        case .headChef: return "flame.fill"
        case .starChef: return "crown.fill"
        }
    }
}

struct ProfileView: View {
    @Query var recipes: [RecipeModel]
    @Query var tags: [TagModel]
    @AppStorage("recipesCompleted") var recipesCompleted: Int = 125
    
    // Logic to determine level and progress
    var currentLevel: ChefLevel {
        if recipesCompleted >= 500 { return .starChef }
        if recipesCompleted >= 201 { return .headChef }
        if recipesCompleted >= 51 { return .sousChef }
        if recipesCompleted >= 11 { return .homeCook }
        return .novice
    }
    
    var nextThreshold: Int {
        switch currentLevel {
        case .novice: return 10
        case .homeCook: return 50
        case .sousChef: return 200
        case .headChef: return 500
        case .starChef: return 1000
        }
    }
    
    var progress: Double {
        Double(recipesCompleted) / Double(nextThreshold)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // 1. HEADER
                Text("Chef Profile")
                    .font(.system(.title, design: .rounded)).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                // 2. PROGRESS RING
                ZStack {
                    // Background Circle
                    Circle()
                        .stroke(currentLevel.color.opacity(0.2), lineWidth: 20)
                    
                    // Progress Circle
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(currentLevel.color.gradient, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .animation(.spring, value: recipesCompleted)
                    
                    VStack(spacing: 8) {
                        Image(systemName: currentLevel.icon)
                            .font(.system(size: 50))
                            .foregroundStyle(currentLevel.color)
                        
                        Text("\(recipesCompleted)")
                            .font(.system(size: 40, weight: .black, design: .rounded))
                        
                        Text("Recipes cooked")
                            .font(.caption.bold())
                            .foregroundStyle(.secondary)
                    }
                }
                .frame(width: 240, height: 240)
                .padding(.top, 20)

                // 3. LEVEL CARD
                VStack(spacing: 12) {
                    Text(currentLevel.rawValue)
                        .font(.title2.bold())
                        .foregroundStyle(currentLevel.color)
                    
                    Text("Next Goal: \(nextThreshold) Recipes")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    ProgressView(value: progress)
                        .tint(currentLevel.color)
                        .padding(.horizontal, 40)
                }
                
                totalRecipesBanner
                
                totalTagsBanner
                
                Spacer()
            }
            .padding(.vertical)
        }
        .background(Color(.systemGroupedBackground))
    }
    
    var totalRecipesBanner: some View {
        HStack(spacing: 20) {
            // A stylized "Book" Icon in a soft teal square
            ZStack {
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(.teal.opacity(0.1))
                    
                Image(systemName: "book.closed.fill")
                    .font(.title2)
                    .foregroundStyle(.teal)
            }
            .frame(width: 54, height: 54)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Total Recipes Stored")
                    .font(.caption.bold())
                    .foregroundStyle(.secondary)
                    .textCase(.uppercase)
                    .tracking(0.5)
                
                Text("\(recipes.count) Entries")
                    .font(.title2.bold())
                    .foregroundStyle(.primary)
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        // Using a subtle border instead of a shadow to make it feel "Informational" not "Clickable"
        .background {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.primary.opacity(0.05), lineWidth: 1)
                )
        }
        .padding(.horizontal)
    }
    
    var totalTagsBanner: some View {
        HStack(spacing: 20) {
            // A stylized "Book" Icon in a soft teal square
            ZStack {
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(.teal.opacity(0.1))
                    
                Image(systemName: "tag.fill")
                    .font(.title2)
                    .foregroundStyle(.indigo)
            }
            .frame(width: 54, height: 54)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Total Tags Stored")
                    .font(.caption.bold())
                    .foregroundStyle(.secondary)
                    .textCase(.uppercase)
                    .tracking(0.5)
                
                Text("\(tags.count) Active Tags")
                    .font(.title2.bold())
                    .foregroundStyle(.primary)
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        // Using a subtle border instead of a shadow to make it feel "Informational" not "Clickable"
        .background {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.primary.opacity(0.05), lineWidth: 1)
                )
        }
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
}
