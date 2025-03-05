//
//  SkillCardView.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 11/09/24.
//

import SwiftUI

struct SkillCardView: View {
    
    var systemImageName: String
    var color: Color
    var text: String
    var num: Int
    
    var body: some View {
        VStack {
            Circle()
                .foregroundStyle(color)
                .frame(height: 60)
                .overlay {
                    Text("\(num)")
                        .font(num > 99 ? .title2 : .largeTitle)
                        .foregroundStyle(.white)
                        .bold()
                        .padding(10)
                }
            Text(text)
                .font(.caption)
                .fontWeight(.semibold)
        }
        .multilineTextAlignment(.center)
        .frame(maxWidth: 80, maxHeight: 100)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 25.0)
                .strokeBorder(color, lineWidth: 2)
        }
        .overlay(alignment: .top) {
            Image(systemName: systemImageName)
                .font(.title2)
                .foregroundStyle(.secondary)
                .padding(.horizontal, 5)
                .background(/*.BG*/)
                .offset(y: -16)
        }
    }
    
}

#Preview {
    SkillCardView(systemImageName: "flame", color: .green, text: "7 challenges completed", num: 19)
}
