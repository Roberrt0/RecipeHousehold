//
//  TestView.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 12/11/24.
//

import SwiftUI
import Combine

/*
 Counter View using Singleton and MVVM
 */

class MyManager {
    @Published var count = 0
    
    static let shared = MyManager()
    
    private init() {}
    
    func increase() {
        count += 1
    }
}

class TestViewModel: ObservableObject {
    @Published var count: Int = 0
    
    let manager = MyManager.shared
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addCountSubscriber()
    }
    
    func addCountSubscriber() {
        manager.$count.sink { newValue in
            self.count = newValue
        }
        .store(in: &cancellables)
    }
    
    func addCountSubscriber2() {
        manager.$count.subscribe(
            on: DispatchQueue.global(qos: .background),
            options: nil).receive(on: DispatchQueue.main)
            .sink { newValue in
                self.count = newValue
            }
            .store(in: &cancellables)
    }
    
    func buttonPressed() {
        withAnimation {
            manager.increase()
        }
    }
}

struct TestView: View {
    
    @StateObject var viewModel = TestViewModel()
    
    var body: some View {
        VStack {
            Text("\(viewModel.count)")
                .font(.title)
                .contentTransition(.numericText())
            Button(action: viewModel.buttonPressed) {
                Text("Press")
            }
            .buttonStyle(ThirdDimensional())
            .frame(width: 100, height: 100)
        }
    }
}

#Preview {
    TestView()
}
