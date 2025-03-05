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
        List {
            ForEach(steps.indices, id: \.self) { index in
                VStack(alignment: .leading, spacing: 20) {
                    Text("step \(index+1)")
                        .font(.headline)
                        .foregroundStyle(.yellow)
                    Text(steps[index])
                }
            }
        }
        .listStyle(.inset)
        .navigationTitle("Instructions")
    }
}

#Preview {
    NavigationStack {
        StepListView(steps: RecipesMockData.getData()[0].steps)
    }
}
