//
//  StepModel.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 31/10/24.
//

import Foundation

struct StepModel: Identifiable {
    let id: String
    var text: String
    
    init(id: String = UUID().uuidString, text: String) {
        self.id = id
        self.text = text
    }
}

// NOT USED
