//
//  ThirdDimensional.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 20/09/24.
//

import Foundation
import SwiftUI

struct ThirdDimensional: ButtonStyle {
    
    @Environment(\.isEnabled) var isEnabled
    let cornerRadiuses: [CGFloat]
    let color: Color = .yellow
    let offset: CGFloat = 5.0
    
    init() {
        self.cornerRadiuses = [25, 25, 25, 25]
    }
    init(topLeadingRadius: CGFloat = 5, bottomLeadingRadius: CGFloat = 5, bottomTrailingRadius: CGFloat = 5, topTrailingRadius: CGFloat = 5) {
        self.cornerRadiuses = [topLeadingRadius, bottomLeadingRadius, bottomTrailingRadius, topTrailingRadius]
    }
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            getShape()
                .fill(isEnabled ? color : .green)
                .brightness(-0.2)
                .offset(y: offset)

            Group {
                getShape()
                    .fill(isEnabled ? color : .green)
                
                if isEnabled {
                    configuration.label
                        .transition(.push(from: .top))
                } else {
                    Image(systemName: "checkmark")
                        .transition(.push(from: .top))
                }
 
            }
            .offset(y: configuration.isPressed || !isEnabled ? offset : 0)

        }
        .compositingGroup()
    }
    
    func getShape() -> UnevenRoundedRectangle {
        UnevenRoundedRectangle(topLeadingRadius: cornerRadiuses[0], bottomLeadingRadius: cornerRadiuses[1], bottomTrailingRadius: cornerRadiuses[2], topTrailingRadius: cornerRadiuses[3])
    }
}

struct ThirdDimensionalTest: View {
    @State var isEnabled = false
    
    var body: some View {
        VStack(spacing: 30) {
            Group {
                Button("click me") {
                    toggleStatus()
                }
                .buttonStyle(ThirdDimensional())
                Button("click me") {
                    
                }
                .buttonStyle(ThirdDimensional(topLeadingRadius: 25, bottomLeadingRadius: 25))
                Button("click me") {
                    
                }
                .buttonStyle(ThirdDimensional(bottomTrailingRadius: 25, topTrailingRadius: 25))
            }
            .foregroundStyle(.white)
            .font(.title)
            .fontDesign(.rounded)
            .bold()
            .frame(maxWidth: .infinity)
            .frame(height: 100)
            .disabled(isEnabled)
            
            Button("toggle") {
                toggleStatus()
            }
        }
        .padding()
    }
    
    func toggleStatus() {
        withAnimation(.easeOut) {
            isEnabled.toggle()
        }
    }
}

#Preview("ThirdDimensional") {
    ThirdDimensionalTest()
}

