//
//  StepListView.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 16/09/24.
//

import SwiftUI

struct StepListView: View {
    let steps: [String]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(Array(steps.enumerated()), id: \.offset) { index, step in
                    HStack(alignment: .top, spacing: 20) {
                        // The Timeline Column
                        VStack(spacing: 0) {
                            Text("\(index + 1)")
                                .font(.caption.bold())
                                .foregroundStyle(.white)
                                .frame(width: 28, height: 28)
                                .background(Circle().fill(.teal))
                            
                            // Draw the line connecting steps (except for the last one)
                            if index != steps.count - 1 {
                                Rectangle()
                                    .fill(.teal.opacity(0.3))
                                    .frame(width: 2)
                                    .frame(maxHeight: .infinity)
                            }
                        }
                        
                        // The Instruction Card
                        VStack(alignment: .leading, spacing: 8) {
                            Text("STEP \(index + 1)")
                                .font(.caption2.bold())
                                .foregroundStyle(.secondary)
                                .tracking(1)
                            
                            Text(step)
                                .font(.body)
                                .lineSpacing(4)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(.bottom, 30) // Creates space for the line
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Instructions")
        .background(Color(.systemGroupedBackground), ignoresSafeAreaEdges: .all)
    }
}

#Preview {
    NavigationStack {
        StepListView(steps: RecipesMockData.getData()[0].steps)
    }
}
