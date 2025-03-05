//
//  RecipeListView.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 03/09/24.
//

import SwiftUI
import Combine


/*
 Todo:
 - try to move navStack to app file
 - add filtering based on tags
 - onmove functionality
 - Favorites
 - Share recipe
 */

class RecipeListViewModel: ObservableObject {
    
    @Published var data: [RecipeModel] = []
    @Published var searchText = ""
    
    let recipesManager = RecipesDataService.shared
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getRecipes()
    }
    
    func getRecipes() {
        data = recipesManager.recipes
    }
    
    func subscribeToRecipes() {
        recipesManager.$recipes.sink { returnedRecipes in
            if self.searchText.isEmpty {
                self.data = returnedRecipes
            } else {
                self.data = returnedRecipes.filter { $0.name.localizedCaseInsensitiveContains(self.searchText)}
            }
        }
        .store(in: &cancellables)
    }
    
    func delete(indexSet: IndexSet) {
        data.remove(atOffsets: indexSet)
    }
}


struct RecipeListView: View {
    
    @StateObject var vm = RecipeListViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.data) { recipe in
                    NavigationLink(value: recipe) {
                        RecipeListRow(recipe: recipe)
                    }
                }
                .onDelete(perform: vm.delete)
            }
            .navigationTitle("Your Recipes")
            .listStyle(.inset)
            .searchable(text: $vm.searchText, prompt: Text("recipe search"))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    NavigationLink(destination: UpdateRecipeView()) {
                        Image(systemName: "plus")
                    }
                    Button {
                        // nothing yet
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                }
            } // toolbar END
            .navigationDestination(for: RecipeModel.self) { recipe in
                RecipeDetail(recipe: recipe)
            }
        } // navstack END
    } // body END
}

#Preview {
    RecipeListView()
}
