//
//  AddRecipeView.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 13/09/24.
//

/* ERROR
 SOBREESCRIBIR codigo para usar el struct de Steps
 para representar la lista de instrucciones
 */

import SwiftUI
import Combine
import SwiftData

class UpdateRecipeViewModel: ObservableObject {
    var recipeTags: [TagModel] = [] // Temporary storage
    
    // form values to save
    @Published var recipeId: String
    @Published var name: String = ""
    @Published var ingredientList: [SafeBindItem] = []
    @Published var stepList: [SafeBindItem] = []
    @Published var allTagsTracker: [TagSelection] = []
    @Published var notes: String = ""
    @Published var prepHours: Int = 0
    @Published var prepMinutes: Int = 0
    
    private let recipesService = RecipesDataService()
    private let tagsService = TagsDataService()
    
    init(recipe: RecipeModel, allAvailableTags: [TagModel]) {
        self.recipeId = recipe.id
        self.name = recipe.name
        self.notes = recipe.notes
        self.recipeTags = recipe.tags
        self.ingredientList = recipe.ingredients.map({ ingredient in
            SafeBindItem(name: ingredient)
        })
        self.stepList = recipe.steps.map({ step in
            SafeBindItem(name: step)
        })
        if let prepTime = recipe.timeToPrep {
            let totalMinutes = Int(prepTime / 60)
            self.prepHours = totalMinutes / 60
            self.prepMinutes = totalMinutes % 60
        }
        self.fillTagsInformation(recipeTags: recipe.tags, allAvailableTags: allAvailableTags)
    }
    
    func fillTagsInformation(recipeTags: [TagModel], allAvailableTags: [TagModel]) {
        guard !allAvailableTags.isEmpty else { return }
        self.allTagsTracker = allAvailableTags.map { tag in
            TagSelection(tag: tag, isIncluded: recipeTags.contains(where: { $0.id == tag.id }))
        }
    }
    
    func saveRecipe(context: ModelContext) {
        // Calculate time
        let totalSeconds = TimeInterval((prepHours * 3600) + (prepMinutes * 60))
        
        // Map bindings back to strings
        let ingredients = ingredientList.map { $0.name }.filter { !$0.isEmpty }
        let steps = stepList.map { $0.name }.filter { !$0.isEmpty }
        
        // Get selected tags
        let selectedTags = allTagsTracker.filter { $0.isIncluded }.map { $0.tag }
        
        // Create the model
        let updatedRecipe = RecipeModel(
            id: recipeId,
            name: name,
            ingredients: ingredients,
            steps: steps,
            tags: selectedTags,
            notes: notes,
            timeToPrep: totalSeconds
        )
        
        // Upsert into SwiftData
        context.insert(updatedRecipe)
        
        // Ping Flask server here!
        // Metrics.log(event: "recipe_updated", metadata: ["id": recipeId])
        MetricsService.sendEvent(.recipeCreated)
    }
    
    // adds an empty ingredient
    func addNewIngredient() {
        ingredientList.append(SafeBindItem(name: ""))
    }
    
    func deleteIngredient(offsets: IndexSet) {
        ingredientList.remove(atOffsets: offsets)
    }
    
    func addNewStep() {
        stepList.append(SafeBindItem(name: ""))
    }
    
    func deleteStep(offsets: IndexSet) {
        stepList.remove(atOffsets: offsets)
    }
    
    // for binding inside a list
    struct SafeBindItem: Identifiable, Hashable {
        let id = UUID()
        var name: String
    }
}

struct UpdateRecipeView: View {
    
    @StateObject var vm: UpdateRecipeViewModel
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query var allTags: [TagModel] // Fetch all tags to show in the picker
    
    init(recipe: RecipeModel = RecipeModel()) {
        _vm = StateObject(wrappedValue: UpdateRecipeViewModel(recipe: recipe, allAvailableTags: []))
    }
    
    var body: some View {
        Form {
            Section {
                TextField("type the name of the recipe", text: $vm.name)
            } header: {
                Text("RECIPE NAME*")
            }
            
            notesSection
            
            ingredientsSection
            
            instructionsSection
            
            timeSection
            
            tagsSection
        }
        .navigationTitle("New Recipe ✏️")
        .onAppear {
            vm.fillTagsInformation(recipeTags: vm.recipeTags, allAvailableTags: allTags)
        }
        .toolbar {
            Button("Save") {
                Task { @MainActor in
                    vm.saveRecipe(context: modelContext)
                    dismiss()
                }
            }
        }
    }
    
    var notesSection: some View {
        Section {
            TextField("type something", text: $vm.notes, axis: .vertical)
                .lineLimit(3...8)
        } header: {
            Text("YOUR NOTES")
        } footer: {
            Text("TIP - write special things that you would like to remember about this recipe")
        }
    }
    
    var ingredientsSection: some View {
        Section {
            ForEach($vm.ingredientList) { $ingredient in
                HStack {
                    TextField("type an ingredient", text: $ingredient.name)
                    Image(systemName: "pencil")
                        .foregroundStyle(.secondary)
                }
            }
            .onDelete(perform: vm.deleteIngredient)

            Button {
                vm.addNewIngredient()
            } label: {
                Label("Add ingredient", systemImage: "plus")
            }
        } header: {
            Text("Ingredients")
        } footer: {
            Text("Slide left to delete an ingredient")
        }
    }
    
    var instructionsSection: some View {
        Section {
            ForEach($vm.stepList) { $step in
                HStack {
                    TextField("type a step", text: $step.name)
                    Image(systemName: "pencil")
                        .foregroundStyle(.secondary)
                }
            }
            .onDelete(perform: vm.deleteStep)

            Button {
                vm.addNewStep()
            } label: {
                Label("Add step", systemImage: "plus")
            }
        } header: {
            Text("INSTRUCTIONS*")
        }
    }
    
    var timeSection: some View {
        Section {
            HStack {
                Picker("Hours", selection: $vm.prepHours) {
                    ForEach(0..<13) {
                        Text("\($0) h").tag($0)
                    }
                }
                .pickerStyle(.menu)

                Picker("Minutes", selection: $vm.prepMinutes) {
                    ForEach(Array(stride(from: 0, through: 55, by: 5)), id: \.self) {
                        Text("\($0) min").tag($0)
                    }
                }
                .pickerStyle(.menu)
            }
        } header: {
            Text("PREP TIME")
        }
    }
    
    var tagsSection: some View {
        Section {
            ForEach($vm.allTagsTracker) { $item in
                Toggle(isOn: $item.isIncluded) {
                    TagView(tag: item.tag)
                }
            }
        } header: {
            Text("TAGS")
        }
    }
}

#Preview {
    NavigationStack {
        UpdateRecipeView()
    }
    .modelContainer(previewContainer)
}
