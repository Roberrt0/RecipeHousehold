//
//  CookingView.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 19/09/24.
//

import SwiftUI

struct CookingView: View {
    
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
            
//            HStack(spacing: 80) {
//                backButton
//                nextButton
//            }
//            .frame(height: 60)
//            .foregroundStyle(.white)
//            .font(.title2)
//            .fontDesign(.rounded)
//            .bold()
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
            Text(tabSelection == (steps.count-1) ? "Finish recipe!":"Complete step")
//                .contentTransition(.numericText())
        }
        .buttonStyle(ThirdDimensional())
    }
    
    var backButton: some View {
        Button {
            backButtonPressed()
        } label: {
//            Text("< back")
            Text("<").padding()
        }
//        .buttonStyle(ThirdDimensional(topLeadingRadius: 25, bottomLeadingRadius: 25))
        .disabled(tabSelection == 0)
    }
    var nextButton: some View {
        Button {
            nextButtonPressed()
        } label: {
//            Text("Next >")
            Text(">").padding()
        }
//        .buttonStyle(ThirdDimensional(bottomTrailingRadius: 25, topTrailingRadius: 25))
        .disabled(tabSelection == (steps.count-1))
    }
    
    func leaveButtonPressed() {
        showAlert.toggle()
    }
    
    func completeButtonPressed() {
        if currentStep == steps.count-1 {
            // final step completed
        } else {
            withAnimation {
                currentStep += 1
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                withAnimation {
                    tabSelection += 1
                }
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
}
