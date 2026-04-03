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
            
            TagManagerView()
                .tabItem {
                    Label("tags", systemImage: "tag")
                }
            
            ProfileView()
                .tabItem {
                    Label("profile", systemImage: "person")
                }
        }
        .onAppear {
            //print("DB Path: \(URL.applicationSupportDirectory.path(percentEncoded: false))")
            MetricsService.sendEvent(.appOpened)
        }
    }
}

#Preview {
   MainView()
        .modelContainer(previewContainer2)
}
