//
//  TagsViewModel.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 14/09/24.
//

import Foundation
import SwiftUI

class TagsViewModel: ObservableObject {
    
    @Published var tags: [TagModel]
    
    let colorChoices: [Color] = [
        .blue,
        .green,
        .yellow,
        .red,
        .purple,
        .mint,
        .indigo,
        .orange,
    ]
    
    init() {
        self.tags = TagsMockData.getData()
    }
    
    func add(title: String, color: Color) {
        let colorName = color.description
        let newTag = TagModel(title: title, colorName: colorName)
        tags.append(newTag)
    }
    
    func delete(_ tag: TagModel) {
        tags.removeAll(where: {$0.id == tag.id})
    }
    
    func move(indexSet: IndexSet, indice: Int) {
        tags.move(fromOffsets: indexSet, toOffset: indice)
    }
    
    func validateTitle(title: String) -> Bool {
        if title.count < 3 {
            return false
        }
        return true
    }
    
}
