//
//  TagSelection.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 07/02/26.
//

import Foundation

struct TagSelection: Identifiable {
    let id: String
    let tag: TagModel
    var isIncluded: Bool

    init(tag: TagModel, isIncluded: Bool) {
        self.id = tag.id
        self.tag = tag
        self.isIncluded = isIncluded
    }
}
