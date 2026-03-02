//
//  RecipeListView.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 03/09/24.
//

import SwiftUI
import Combine
import SwiftData


enum SortOption: String, CaseIterable {
    case name = "A-Z"
    case prepTime = "Prep Time"
    case tag = "By Tag"
}

struct RecipeListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \RecipeModel.name) var recipes: [RecipeModel]
    @Query(sort: \TagModel.title) var allTags: [TagModel]
    
    @State private var recipeToEdit: RecipeModel? = nil
    @State private var searchText = ""
    @State private var selectedSort: SortOption = .name
    @State private var selectedTagFilter: TagModel? = nil
    
    var filteredRecipes: [RecipeModel] {
           var result = recipes
           
           // 1. Search Filter
           if !searchText.isEmpty {
               result = result.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
           }
           
           // 2. Tag Filter (Only one at a time)
           if selectedSort == .tag, let targetTag = selectedTagFilter {
               result = result.filter { recipe in
                   recipe.tags.contains(where: { $0.id == targetTag.id })
               }
           }
           
           // 3. Sorting Logic
           switch selectedSort {
           case .name:
               return result.sorted { $0.name < $1.name }
           case .prepTime:
               return result.sorted { ($0.timeToPrep ?? 0) < ($1.timeToPrep ?? 0) }
           case .tag:
               return result // Already filtered by tag above
           }
       }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(filteredRecipes) { recipe in
                        NavigationLink(value: recipe) {
                            RecipeListRow(recipe: recipe)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                // DELETE BUTTON
                                Button(role: .destructive) {
                                    modelContext.delete(recipe)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }

                                // EDIT BUTTON
                                Button {
                                    recipeToEdit = recipe
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .tint(.orange) // Classic "Edit" color
                            }
                    }
                } header: {
                    if !filteredRecipes.isEmpty {
                        Text("\(filteredRecipes.count) Total Recipes")
                            .font(.caption2.bold())
                            .tracking(1)
                    }
                }
            }
            .navigationTitle("Cookbook")
            .listStyle(.insetGrouped)
            .searchable(text: $searchText, prompt: "Find a recipe...")
            .overlay {
                if recipes.isEmpty {
                    ContentUnavailableView(
                        "Your Book is Empty",
                        systemImage: "book.pages",
                        description: Text("Add your first recipe to start your collection.")
                    )
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("insert 10000") {
                        RecipesDataService.stressTestDatabase(count: 10000, context: modelContext, allTags: allTags)
                    }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    NavigationLink(destination: UpdateRecipeView()) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                            .foregroundStyle(.teal)
                    }
                    
                    filtersMenu
                }
            }
            .navigationDestination(for: RecipeModel.self) { recipe in
                RecipeDetail(recipe: recipe)
            }
            .navigationDestination(item: $recipeToEdit) { recipe in
                UpdateRecipeView(recipe: recipe)
            }
        }
    }
    
    var filtersMenu: some View {
        // THE FILTER MENU
        Menu {
            Section("Sort By") {
                Button { selectedSort = .name } label: {
                    Label("A-Z", systemImage: "textformat.abc")
                }
                Button { selectedSort = .prepTime } label: {
                    Label("Prep Time", systemImage: "clock")
                }
            }
            
            Section("Filter by Tag") {
                ForEach(allTags) { tag in
                    Button {
                        selectedSort = .tag
                        selectedTagFilter = tag
                    } label: {
                        HStack {
                            Text(tag.title)
                            if selectedTagFilter == tag && selectedSort == .tag {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            }
            
            if selectedSort != .name || selectedTagFilter != nil {
                Button(role: .destructive) {
                    selectedSort = .name
                    selectedTagFilter = nil
                } label: {
                    Label("Reset Filters", systemImage: "xmark.circle")
                }
            }
        } label: {
            Image(systemName: selectedSort == .name && selectedTagFilter == nil ? "line.horizontal.3.decrease.circle" : "line.horizontal.3.decrease.circle.fill")
                .foregroundStyle(
                    selectedSort == .name && selectedTagFilter == nil
                    ? AnyShapeStyle(.secondary)
                    : AnyShapeStyle(.teal)
                )
        }
    }
}


#Preview {
    RecipeListView()
        .modelContainer(previewContainer)
}
