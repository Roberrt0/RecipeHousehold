//
//  HomeView.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 03/09/24.
//

import SwiftUI

/*
 ToDo:
 - ChangeLayout to accomodate more buttons like
 Change weekly challenge button
 Go to Calendar? / change planner button name
 
 - figure out where to put/manage add recipe via link
 - search/make icons and art for my app
 */

struct HomeView: View {
    
    @State private var progress = 80.0
    
    var body: some View {
        
        NavigationStack {
            VStack {
                challengeSection
                
                VStack(spacing: 25) {
                    NavigationLink(destination: UpdateRecipeView()) {
                        addRecipeButton
                    }
                    
                    NavigationLink(destination: TagManagerView()) {
                        manageTagsButton
                    }
                    
                    plannerButton
                    
                    Spacer()
                    
                }
                .padding()
            }
        }
        
    }
}


// MARK: COMPONENTS

extension HomeView {
    var challengeSection: some View {
        ZStack(alignment: .bottom) {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Weekly challenge")
                        .font(.title)
                        .foregroundStyle(.yellow)
                        .fontWeight(.semibold)
                        .fixedSize()
                    Text("Add a new recipe to your RecipeShelf!")
                        .font(.headline)
                }
                
                Image(systemName: "flame.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 75)
            }
            .padding(30)
            .padding(.bottom, 30)
            .frame(maxWidth: .infinity)
            
            ProgressView(" progress: \(Int(progress))%",value: progress, total: 100)
                .font(.headline)
                .tint(.yellow)
                .ignoresSafeArea(edges: .horizontal)
        }
//        .background(Color.black.opacity(0.2).ignoresSafeArea(edges: .top))
    } // challengeSection END
    
    var addRecipeButton: some View {
        ZStack(alignment: .bottomTrailing) {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom))
                .overlay(alignment: .topLeading) {
                    Text("Add a new recipe")
                        .foregroundStyle(.white)
                        .font(.title)
                        .fontWeight(.heavy)
                        .italic()
                        .padding()
                }
            
            Image(systemName: "pencil.and.scribble")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(height: 125)
                .opacity(0.3)
            
            Image(systemName: "plus")
                .font(.largeTitle)
                .foregroundStyle(.white)
                .padding()
        }
        .frame(maxHeight: 150)
    }
    
    var manageTagsButton: some View {
        ZStack(alignment: .bottomTrailing) {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(LinearGradient(colors: [.green, .teal], startPoint: .top, endPoint: .bottom))
                .overlay(alignment: .topLeading) {
                    Text("Manage Tags")
                        .foregroundStyle(.white)
                        .font(.title)
                        .fontWeight(.heavy)
                        .italic()
                        .padding()
                }
            
            Image(systemName: "tag")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(height: 125)
                .opacity(0.3)
                .padding(.horizontal)
            
            Image(systemName: "list.bullet.rectangle.portrait.fill")
                .font(.title)
                .foregroundStyle(.white)
                .padding()
        }
        .frame(maxHeight: 150)
    }
    
    var plannerButton: some View {
        ZStack(alignment: .bottomTrailing) {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(LinearGradient(colors: [.purple, .indigo], startPoint: .top, endPoint: .bottom))
                .overlay(alignment: .topLeading) {
                    Text("Plan a recipe")
                        .foregroundStyle(.white)
                        .font(.title)
                        .fontWeight(.heavy)
                        .italic()
                        .padding()
                }
            
            Image(systemName: "calendar")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(height: 125)
                .opacity(0.3)
                .padding(.horizontal)
            
            Image(systemName: "pin.fill")
                .font(.title)
                .foregroundStyle(.white)
                .padding()
        }
        .frame(maxHeight: 150)
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .background(.BG)
    }
}
