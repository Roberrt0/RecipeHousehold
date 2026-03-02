//
//  TagView.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 18/10/24.
//

import SwiftUI

struct TagView: View {
    
    let tag: TagModel
    
    init(tag: TagModel) {
        self.tag = tag
    }
    
    var body: some View {
        Text(tag.title)
            .padding(.all, 5)
            .font(.body)
            .background(tag.color.swiftUIColor)
            .foregroundColor(Color.white)
            .cornerRadius(5)
    }
    
}

#Preview {
    TagView(tag: TagModel(title: "Some tag", color: TagColor.blue))
}
