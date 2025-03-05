//
//  HomeView.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 01/09/24.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView {
                RecipeListView()
                    .tabItem {
                        Label("recipes", systemImage: "books.vertical")
                    }
                
                HomeView()
                    .tabItem {
                        Label("home", systemImage: "house.fill")
                    }
                
                ProfileView()
                    .tabItem {
                        Label("profile", systemImage: "person")
                    }
        }
    }
    
}

#Preview {
   MainView()
}
