//
//  AddRecipesHomeButton.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 03/09/24.
//

import SwiftUI

struct AddRecipesHomeButton: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            // background
            RoundedRectangle(cornerRadius: 25.0)
                .fill(LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom))
                .overlay(alignment: .bottomTrailing) {
                    Image(systemName: "plus")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .padding()
                }
            Image(systemName: "pencil.and.scribble")
                .resizable()
                .scaledToFit()
                .frame(height: 125)
                .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .bottomTrailing)
                .opacity(0.3)
            
            
            // foreground
            VStack(alignment: .leading) {
                Text("Add a new recipe")
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontWeight(.heavy)
                    .italic()
                
//                Text("lorem ipsum some random txt")
//                    .foregroundStyle(.white)
//                    .font(.headline)
            }
            .padding()
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
    }
}

#Preview {
    AddRecipesHomeButton()
        .padding()
}
