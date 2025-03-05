//
//  RecipeDetail.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 03/09/24.
//

import SwiftUI

// use link as recipe item vs use recipe as additional property
// use link as recipe item is probably better

struct RecipeDetail: View {
    
    var recipe: RecipeModel
    var tags: [String] = [
        "High calories", "High in sugars", "Vegan", "Glutten free", "Small portions", "another tag"
    ]
    @Environment(\.presentationMode) var presentationmode
    
    init(recipe: RecipeModel) {
        self.recipe = recipe
    }
    
    var body: some View {
        ScrollView {
            Image("testingImage")
                .resizable()
                .scaledToFill()
                .overlay(alignment: .bottomLeading) {
                    VStack(alignment: .leading) {
                        Button {
                            presentationmode.wrappedValue.dismiss()
                        } label: {
                            HStack {
                                Image(systemName: "chevron.left.circle.fill")
                                    .bold()
                                    .font(.largeTitle)
//                                Text("back")
                            }
//                            .padding(10)
//                            .background()
//                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
//                            .clipShape(Circle())
                        }
                        .padding(.top, 50)
                        
                        Spacer()
                        
                        HStack(alignment: .bottom) {
                            Text("Almond chocolate cake")
                                .foregroundStyle(.white)
                                .font(.title)
                                .bold()
                                .shadow(radius: 5)
                            
                            Spacer()
                            
                            Image(systemName: "heart")
                                .foregroundStyle(.pink)
                                .font(.title)
                        }
                    }
                    .padding()
                }
                .frame(height: 350)
            
            VStack(alignment: .leading, spacing: 30) {
                
                tagsSection
                
                threeStats
                
                Divider()
                
                someButtons
                
                Divider()
                
                notesSection
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 5)
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden() // use only when using a custom back button
    }
    
    var tagsSection: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Tags")
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.leading, 10)
            TagCloudView()
        }
    }
    
    var threeStats: some View {
        HStack {
            VStack(spacing: 5) {
                Text("Prep time").frame(width: 100)
                Text("1hr 32m").font(.title3).bold()
            }
            
            Spacer()
            
            VStack(spacing: 5) {
                Text("Ingredients").frame(width: 100)
                Text("34").font(.title3).bold()
            }
            
            Spacer()
            
            VStack(spacing: 5) {
                Text("Steps").frame(width: 100)
                Text("12").font(.title3).bold()
            }
        }
    }
    
    var someButtons: some View {
        VStack(spacing: 10) {
            
            NavigationLink(destination: IngredientsListView()) {
                HStack {
                    Text("Check the ingredients list")
                    Spacer()
                    Image(systemName: "arrow.right").bold()
                }
                .foregroundStyle(.white)
                .padding()
                .background(.teal)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
            }
            
            NavigationLink(destination: StepListView(steps: recipe.steps)) {
                HStack {
                    Text("Review the instructions")
                    Spacer()
                    Image(systemName: "arrow.right").bold()
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(.teal)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
            }
            
            NavigationLink(destination: CookingView(steps: recipe.steps)) {
                HStack {
                    Text("Start cooking!")
                    Image(systemName: "cooktop.fill")
                }
                .foregroundStyle(.white)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(LinearGradient(colors: [.yellow, .orange], startPoint: .topLeading, endPoint: .trailing))
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .padding(.horizontal, 20)
                .padding(.top, 10)
            }
            
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
    }
    
    var notesSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Your notes")
                .font(.title)
                .fontWeight(.semibold)
            Text("These are the notes of the user that are supposed to mention something whatever the user desires to place here will be shown in this whole paragraph but right now im just writing a placeholder to visualize it in my preview i love swiftui.")
        }
    }
}

#Preview {
    NavigationStack {
        RecipeDetail(recipe: RecipesMockData.getData()[0])
    }
}





// overlay withour back button

//Text("Almond chocolate cake")
//    .foregroundStyle(.white)
//    .font(.largeTitle)
//    .bold()
//    .shadow(radius: 5)
//    .padding()


// overlay with back button

//VStack(alignment: .leading) {
//    Button {
//        presentationmode.wrappedValue.dismiss()
//    } label: {
//        HStack {
//            Image(systemName: "chevron.backward").bold()
//            Text("back")
//        }
//        .padding(10)
//        .background()
//        .clipShape(RoundedRectangle(cornerRadius: 25.0))
//    }
//    
//    Spacer()
//    
//    Text("Almond chocolate cake")
//        .foregroundStyle(.white)
//        .font(.largeTitle)
//        .bold()
//        .shadow(radius: 5)
//}
//.padding()
