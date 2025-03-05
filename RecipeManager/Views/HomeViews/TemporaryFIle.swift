//
//  TemporaryFIle.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 26/09/24.
//

/*
import Foundation
import SwiftUI

class ListViewModel: ObservableObject {
    
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    let itemsKey: String = "items_list"
    let colorChoices: [Color] = [
        .blue,
        .green,
        .yellow,
        .red,
        .cyan,
        .mint,
        .orange,
        .pink,
        .indigo,
        .purple,
    ]
    
    init() {
        getItems()
    }
    
    // fetch items from UserDefaults - called in the initializer
    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        
        items = savedItems
    }
    
    // basic functions to manage the list
    func addItem(title: String, color: Color) {
        items.append(ItemModel(title: title, isComplete: false, color: color))
    }
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    func moveItem(from indexSet: IndexSet, to index: Int) {
        items.move(fromOffsets: indexSet, toOffset: index)
    }
    func updateItem(item: ItemModel) {
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items[index] = item.updateCompletion()
        }
    }
    
    // validate the user input (this should NOT go inside the view model)
    func validateTitle(title: String) -> Bool {
        if title.count < 3 {
            return false
        }
        return true
    }
    
    // save items to UserDefaults, always called when the items list changes
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}

*/
