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



class UpdateRecipeViewModel: ObservableObject {
    
    typealias TagBoolTuple = [(tag: TagModel, hasTag: Bool)]
    
    // recipe to update
    @Published var recipe: RecipeModel
    @Published var allTagsTracker: TagBoolTuple
    @Published var stepList: [StepModel]
    
    let recipeManager = RecipesDataService.shared
    let tagsManager = GlobalTagsManager.shared
    var cancellables = Set<AnyCancellable>()
    
    init(recipe: RecipeModel) {
        self.recipe = recipe
        self.stepList = recipe.steps.map({ description in
                .init(text: description)
        })
        allTagsTracker = [] // placed this here to avoid the error
        addTagsSubscriber()
    }
    
    func saveRecipe() {
        var newRecipe = recipe
        newRecipe.steps = stepList.map { item in
            item.text
        }
        newRecipe.tags = allTagsTracker.map { item in
            item.tag
        }
        recipeManager.add(recipe: newRecipe)
    }
    
    // gets global tags from manager
    func addTagsSubscriber() { /*
//        let globalTags = tagsManager.tags
//        var tagList: TagBoolTuple = []
//        for tag in globalTags {
//            let item = (tag, false)
//            tagList.append(item)
//        }
//        allTagsTracker = tagList
        */
        tagsManager.$tags.sink { completion in
            switch completion {
            case .finished:
                print("Success fetching global tags")
            case .failure(let error):
                print("Error fetching global tags. \(error.localizedDescription)")
            
            }
        } receiveValue: { returnedTags in
            self.allTagsTracker = returnedTags.map({ tag in
                return (tag: tag, hasTag: self.recipe.tags.contains(where: {$0 == tag}))
            })
        }
        .store(in: &cancellables)
    }
    
    // adds an empty ingredient
    func addNewIngredient() {
        let newIngredient = IngredientModel(name: "")
        recipe.ingredients.append(newIngredient)
    }
    
    func deleteIngredient(offsets: IndexSet) {
        recipe.ingredients.remove(atOffsets: offsets)
    }
    
    func addNewStep() {
        let newStep = StepModel(text: "")
        stepList.append(newStep)
    }
    
    func deleteStep(offsets: IndexSet) {
        stepList.remove(atOffsets: offsets)
    }
}

struct UpdateRecipeView: View {
    
    @StateObject var vm: UpdateRecipeViewModel
    
    init(recipe: RecipeModel = RecipeModel()) {
        let wrappedValue = UpdateRecipeViewModel(recipe: recipe)
        _vm = StateObject(wrappedValue: wrappedValue)
    }
    
    var body: some View {
        Form {
            Section {
                TextField("type the name of the recipe", text: $vm.recipe.name)
            } header: {
                Text("RECIPE NAME*")
            }
            
            notesSection
            
            ingredientsSection
            
            instructionsSection
            
            tagsSection

        }
        .navigationTitle("New Recipe ✏️")
        .safeAreaInset(edge: .bottom) {
            saveButton
        }
    }
    
    var notesSection: some View {
        Section {
            TextField("type something", text: $vm.recipe.notes, axis: .vertical)
                .lineLimit(3...8)
        } header: {
            Text("YOUR NOTES")
        } footer: {
            Text("TIP - write special things that you would like to remember about this recipe")
        }
    }
    
    var ingredientsSection: some View {
        Section {
            List {
                ForEach($vm.recipe.ingredients) { $ingredient in
                    HStack {
                        TextField("type an ingredient", text: $ingredient.name)
                        Image(systemName: "pencil").foregroundStyle(.secondary)
                    }
                }
                .onDelete(perform: vm.deleteIngredient)
                
                Button {
                    vm.addNewIngredient()
                } label: {
                    Label( "Add ingredient", systemImage: "plus")
                }
            }
        } header: {
            Text("Ingredients")
        } footer: {
            Text("Slide left to delete an ingredient")
        }
    }
    
    var instructionsSection: some View {
        Section {
            List {
                ForEach($vm.stepList) { $step in
                    HStack {
                        TextField("type a step", text: $step.text)
                        Image(systemName: "pencil").foregroundStyle(.secondary)
                    }
                }
                .onDelete(perform: vm.deleteStep)
                
                Button {
                    vm.addNewStep()
                } label: {
                    Label( "Add step", systemImage: "plus")
                }
            }
        } header: {
            Text("INSTRUCTIONS*")
        }
    }
    
    var tagsSection: some View {
        Section {
            List {
                ForEach($vm.allTagsTracker, id: \.tag.id) { $item in

                    Toggle(isOn: $item.hasTag) {
                        TagView(tag: item.tag)
                    }
                    
                }
            }
        } header: {
            Text("TAGS")
        }
    }
    
    var saveButton: some View {
        Button {
            var savedRecipe = vm.recipe
            
            print("RESULT:\n\(savedRecipe)")
        } label: {
            Text("SAVE")
//                Label("create", systemImage: "plus")
                .font(.headline)
                .foregroundStyle(.white)
        }
        .buttonStyle(ThirdDimensional())
        .frame(/*maxWidth: 200, */maxHeight: 60)
        .padding(.horizontal, 40)
    }
}

#Preview {
    NavigationStack {
        UpdateRecipeView()
    }
}


//class UpdateRecipeViewModel: ObservableObject {
//    
//    // recipe to update
//    @Published var recipe: RecipeModel
//    
//    let tagsManager = GlobalTagsManager.shared
//    
//    // temporary variables
//    @Published var name: String
//    @Published var ingredientStrings: [String]
//    @Published var steps: [String]
//    @Published var tags: [TagModel]
//    @Published var notes: String
//    @Published var imageName: String
//    @Published var timeToPrep: Int?
//    
//    init(recipe: RecipeModel = RecipesMockData.getData()[0]) {
//        self.recipe = recipe
//        self.name = recipe.name
//        self.ingredientStrings = recipe.ingredients.map { $0.name }
//        self.steps = recipe.steps
//        self.tags = recipe.tags
//        self.notes = recipe.notes
//        self.imageName = recipe.imageName
//        self.timeToPrep = recipe.timeToPrep
//    }
//    
//    func setUpTags(from: [TagModel]) {
//        let globalTags = tagsManager.tags
//        for tag in globalTags {
//            
//        }
//    }
//    
//}
//
//struct UpdateRecipeView: View {
//    
//    @StateObject var vm = UpdateRecipeViewModel()
//    
//    var body: some View {
//        Form {
//            Section {
//                TextField("type the name of the recipe", text: $vm.name)
//            } header: {
//                Text("RECIPE NAME")
//            }
//            
//            Section {
//                TextField("type something", text: $vm.notes, axis: .vertical)
//                    .lineLimit(3...8)
//            } header: {
//                Text("YOUR NOTES")
//            } footer: {
//                Text("TIP - write special things that you would like to remember about this recipe")
//            }
//            
//            ingredientsSection
//            
//            instructionsSection
//            
//            tagsSection
//
//        }
//        .navigationTitle("New Recipe ✏️")
//    }
//    
//    var ingredientsSection: some View {
//        Section {
//            List {
//                ForEach($vm.ingredientStrings, id: \.self) { $ingredient in
//                    HStack {
//                        TextField("type an ingredient", text: $ingredient)
//                        Image(systemName: "pencil").foregroundStyle(.secondary)
//                    }
//                }
//                
//                Button {
//                    vm.ingredientStrings.append("")
//                } label: {
//                    Label( "Add another ingredient", systemImage: "plus")
//                }
//            }
//        } header: {
//            Text("Ingredients")
//        }
//    }
//    
//    var instructionsSection: some View {
//        Section {
//            Text("heheh")
//        } header: {
//            Text("Instructions")
//        }
//    }
//    
//    var tagsSection: some View {
//        Section {
//            List {
//                ForEach(vm.recipe.tags) { tag in
//
//                    // for each global tags duh
//                    // either find a way to implement native functions
//                    // or just make a custom add/remove and make tagsPropety a set
//                    
//                }
//            }
//        } header: {
//            Text("TAGS")
//        }
//    }
//}
//
//#Preview {
//    NavigationStack {
//        UpdateRecipeView()
//    }
//}


//        let globalTags = tagsManager.tags
//        var tagList: TagBoolTuple = []
//        for tag in globalTags {
//            let item = (tag, false)
//            tagList.append(item)
//        }
//        allTagsTracker = tagList
        
