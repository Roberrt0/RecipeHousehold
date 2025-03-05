//
//  ProfileView.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 01/09/24.
//

import SwiftUI

/*
 ToDo
 - use ProfilePic Border as level indicator
 - SettingsView
 */

struct ProfileView: View {
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                // profile pic and username
                VStack(spacing: 5) {
                    ProfilePictureView()
                        .frame(height: 180)
                    Text("Username123").underline(pattern: .solid)
                        .font(.title)
                        .bold()
                        .padding(10)
                }
                
                // favorite recipe section
                Text("Your favorite recipe:")
                    .font(.headline)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                RecipeListRow(recipe: RecipesMockData.getData().randomElement()!)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .background(RoundedRectangle(cornerRadius: 25.0).stroke(.gray, lineWidth: 2))
                HStack(spacing: 0) {
                    Text("you've prepared this recipe a total of ")
                        .foregroundStyle(.secondary)
                    Text("23").fontWeight(.semibold)
                    Text(" times!")
                        .foregroundStyle(.secondary)
                }
                
                Divider()
                // Stats section
                Text("Stats")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal)
                
                statsSection
                
                Spacer()
            }
            
            .overlay(alignment: .topTrailing) {
                NavigationLink(destination: Text("settings")) {
                    Image(systemName: "gearshape.fill").font(.title).tint(.black)
                }
            }
            .padding()
            .background(alignment: .top ){
                LinearGradient(colors: [.yellow, .orange], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea(edges: .top)
                    .frame(height: 180)
            }
        }
    }
    
    var statsSection: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 30) {
                SkillCardView(systemImageName: "books.vertical", color: .yellow, text: "total recipes saved", num: 1)
                SkillCardView(systemImageName: "checkmark.circle", color: .green, text: "recipes prepared", num: 12)
                SkillCardView(systemImageName: "flame", color: .red, text: "challenges completed", num: 19)
                SkillCardView(systemImageName: "person.2.fill", color: .purple, text: "Recipes shared", num: 6)
            }.padding(.top)
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
}
