//
//  TagsViewModel.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 14/09/24.
//

import Foundation
import SwiftUI
import SwiftData

class TagsDataService: ObservableObject {
      static func add(title: String, color: TagColor, context: ModelContext) {
          let newTag = TagModel(title: title, color: color)
          context.insert(newTag)
          
          // DevOps Tip: You could trigger a Flask metric here:
          // MetricService.send(event: "tag_created")
      }
      
      // 2. Logic for deleting
      static func delete(_ tag: TagModel, context: ModelContext) {
          context.delete(tag)
      }
      
      // 3. Validation Logic (Perfect for Unit Testing in CI/CD)
      static func validateTitle(title: String) -> Bool {
          return title.trimmingCharacters(in: .whitespaces).count >= 3
      }
}

