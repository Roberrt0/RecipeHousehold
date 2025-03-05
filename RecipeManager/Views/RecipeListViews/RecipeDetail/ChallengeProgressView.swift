//
//  ChallengeProgressView.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 04/09/24.
//

import SwiftUI

struct ChallengeProgressView: View {
    
    @Binding var currentStep: Int
    var stepsNum: Int
    private var transition: AnyTransition = .scale
    
    init(currentStep: Binding<Int>, stepsNum: Int) {
        self._currentStep = currentStep
        self.stepsNum = stepsNum
    }
    
    var body: some View {
        // the real one
        progressBar
        
        // for previews
//        VStack(spacing: 50) {
//            progressBar
//            
//            progressController
//        }
//        .padding()
    }
    
    var progressBar: some View {
        HStack(spacing: 0) {
            ForEach(0 ..< stepsNum, id:\.self) { step in
                Circle().stroke(lineWidth:  3)
                    .background()
                    .frame(width: 40, height: step <= currentStep ? 40 : 15)
                    .foregroundStyle(step < currentStep ? Color.primary : Color.gray)
                    .overlay {
                        if step < currentStep {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(.primary)
                                .transition(transition)
                        }
                    }
                if step < stepsNum - 1{
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(height: 3)
                            .foregroundStyle(.gray)
                        Rectangle()
                            .frame(height: 3)
                            .frame(maxWidth: step >= currentStep ? 0 : .infinity, alignment: .leading)
                            .foregroundStyle(.primary)
                    }
                }
            }
        }
        .background {
            Rectangle()
                .frame(height: 3)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.trailing)
        }
        
        
    }
    
    var progressController: some View {
        VStack {
            Text("currentStep: \(currentStep)")
            HStack {
                Button("decrease") {
                    withAnimation {
                        currentStep -= 1
                    }
                }
                Button("decrease") {
                    withAnimation {
                        currentStep += 1
                    }
                }
            }
        }
    }
}

#Preview {
    ChallengeProgressView(currentStep: .constant(3), stepsNum: 10)
}





//var progressBar: some View {
//    HStack {
//        Group {
//            UnevenRoundedRectangle(cornerRadii: .init(topLeading: 25, bottomLeading: 25))
//                .fill(progress >= 1 ? .white : .white)
//            Rectangle()
//                .fill(progress >= 2 ? .white : .white)
//            UnevenRoundedRectangle(cornerRadii: .init(bottomTrailing: 25, topTrailing: 25))
//                .fill(progress >= 3 ? .white : .white)
//        }
//        .shadow(color: .yellow, radius: 5)
//        .brightness(0.1)
//    }
//    .frame(height: 20)
//}
//
//var progressBar2: some View {
//    ZStack {
//        Capsule().frame(height: 5)
//            .foregroundStyle(.white)
//        Capsule().frame(width: height: 5)
////            ProgressView(value: Float(progress), total: Float(checkpoints))
//            .animation(.easeIn, value: progress)
//        HStack {
//            ForEach(1...checkpoints, id: \.self) { checkpoint in
//                Spacer()
//                Circle()
//                    .foregroundStyle(.white)
//                    .frame(height: 10)
//                    .background() {
//                        Circle()
//                            .frame(width: 20, height: 20)
//                    }
//                    
//            }
//        }
//    }
//    .compositingGroup()
//    .foregroundStyle(.yellow)
//}
