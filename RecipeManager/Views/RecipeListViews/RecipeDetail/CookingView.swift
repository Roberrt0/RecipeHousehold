//
//  CookingView.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 19/09/24.
//

import SwiftUI

struct CookingView: View {
    
    @AppStorage("recipesCompleted") var recipesCompleted: Int = 0
    @Environment(\.presentationMode) var presentationMode
    var steps: [String]
    @State var tabSelection = 0
    @State var currentStep = 0
    @State var showAlert = false
    
    init(steps: [String]) {
        self.steps = steps
    }
    
    var body: some View {
        VStack {
            ChallengeProgressView(currentStep: $currentStep, stepsNum: steps.count)
//            Text("Progress").font(.caption).bold()
            HStack {
                leaveButton
                Spacer()
            }.padding(.top)
            
            Spacer()
            
            TabView(selection: $tabSelection) {
                ForEach(steps.indices, id:\.self) { index in
                    VStack(spacing: 20) {
                        Text("Step \(index+1)")
                            .font(.largeTitle)
                            .bold()
                            .foregroundStyle(.yellow)
                        
                        Text(steps[index])
                            .tabItem { Text("label") }
                            .tag(index)
                    }
                }
            }
//            .animation(.default, value: tabSelection)
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            Spacer()
            
            HStack {
                Group {
                    backButton
                    
                    if currentStep >= tabSelection {
                        completeButton
                            .foregroundStyle(.white)
                            .font(.title2)
                            .frame(height: 60)
                            .disabled(currentStep > tabSelection)
                    } else {
                        Spacer()
                    }
                    
                    nextButton
                }
                .font(.largeTitle)
                .fontDesign(.rounded)
                .bold()
            }
        }
        .alert("Stop cooking?\nprogress will be lost", isPresented: $showAlert, actions: {
            HStack {
                Button("Stay", role: .cancel) {
                    //nothin
                }
                Button("Leave", role: .destructive) {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        })
        .navigationBarBackButtonHidden()
        .padding()
    }
    
    var leaveButton: some View {
        Button {
            leaveButtonPressed()
        } label: {
            Text("< Leave")
                .foregroundStyle(.red)
        }
    }
    
    var completeButton: some View {
        Button {
            completeButtonPressed()
        } label: {
            Text(tabSelection == (steps.count-1) ? "Finish":"Complete step")
        }
        .buttonStyle(ThirdDimensional())
    }
    
    var backButton: some View {
        Button {
            backButtonPressed()
        } label: {
            Text("<").padding()
        }
        .disabled(tabSelection == 0)
    }
    var nextButton: some View {
        Button {
            nextButtonPressed()
        } label: {
            Text(">").padding()
        }
        .disabled(tabSelection == (steps.count-1))
    }
    
    func leaveButtonPressed() {
        showAlert.toggle()
    }
    
    func completeButtonPressed() {
        if currentStep == steps.count-1 {
            presentationMode.wrappedValue.dismiss()
            recipesCompleted += 1
        } else {
            withAnimation { currentStep += 1 }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                withAnimation { tabSelection += 1 }
            }
        }
    }
    
    func backButtonPressed() {
        withAnimation {
            tabSelection -= 1
        }
    }
    func nextButtonPressed() {
        withAnimation {
            tabSelection += 1
        }
    }
}

#Preview {
    VStack {
        CookingView(steps: RecipesMockData.getData()[0].steps)
    }
    .modelContainer(previewContainer)
}
