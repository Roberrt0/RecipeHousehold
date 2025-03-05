//
//  GlobalTagsManager.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 26/10/24.
//

import Foundation

// singleton class that controls the persistence of global tags

class GlobalTagsManager {
    
    static let shared = GlobalTagsManager()
    @Published var tags: [TagModel] = []
    
    private init() {
        getGlobalTags()
    }
    
    func getGlobalTags() {
        let tagsArray = TagsMockData.getData()
        tags = tagsArray
    }
    
    func addTag(_ tag: TagModel) {
        tags.append(tag)
    }
    
    func removeTag(id: String) {
        tags.removeAll { tag in
            tag.id == id
        }
    }
    
}


