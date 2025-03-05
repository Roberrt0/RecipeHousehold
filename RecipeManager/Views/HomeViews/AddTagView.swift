//
//  AddTagView.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 26/09/24.
// "Add an item ✏️"

import SwiftUI

struct AddTagView: View {
    
    @ObservedObject var vm: TagsViewModel
    
    init(vm: TagsViewModel) {
        self.vm = vm
    }
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    @State var textFieldText: String = ""
    @State var colorSelected: Color = .blue
    
    @State var showAlert: Bool = false
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
    
    let columns = [GridItem(.adaptive(minimum: 60))]
    
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("New tag ✏️")
                .font(.title)
                .fontWeight(.semibold)
            
            Group {
                TextField("Type a tag's name..." ,text: $textFieldText)
                    .padding()
                    .background(Color.secondary.brightness(colorScheme == .dark ? -0.5 : 0.5))
                    .clipShape(.rect(cornerRadius: 10))
                
                colorPalette
            }
            .padding(.horizontal)
            
            Spacer()
            
            saveButton
        }
        .padding()
        .alert(alertTitle, isPresented: $showAlert, actions: {},message: {Text(alertMessage)})
    }
}

// MARK: COMPONENTS
extension AddTagView {
    var saveButton: some View {
        Button {
            saveButtonPressed()
        } label: {
            Text("Save".uppercased())
                .font(.headline)
                .foregroundStyle(.white)
        }
        .buttonStyle(ThirdDimensional())
        .frame(maxWidth: .infinity)
        .frame(height: 60)
    }
    
    var colorPalette: some View {
        LazyVGrid(columns: columns, content: {
            ForEach(vm.colorChoices, id: \.self) { color in
                ZStack {
                    Circle()
                        .fill(color)
                        .frame(width: 50)
                        .onTapGesture {
                            colorPressed(color: color)
                        }
                        .padding(10)
                    
                    if color == colorSelected {
                        Circle()
                            .stroke(color, style: StrokeStyle(lineWidth: 5))
                            .frame(width: 60, height: 60)
                    }
                }
            }
        })
    }
}

// MARK: FUNCTIONS
extension AddTagView {
    func saveButtonPressed() {
        if !vm.validateTitle(title: textFieldText) {
            alertTitle = "Invalid text!"
            alertMessage = "your text should at least have 3 characters 🤓"
            showAlert.toggle()
            return
        }
        vm.add(title: textFieldText, color: colorSelected)
        presentationMode.wrappedValue.dismiss()
    }
    
    func colorPressed(color: Color) {
        colorSelected = color
    }
}

#Preview {
    NavigationStack {
        AddTagView(vm: TagsViewModel())
    }
}

// for testing
struct AddViewSheetTest: View {
    
    @State private var showSheet: Bool = false
    @State private var detent: PresentationDetent = .medium
    
    var body: some View {
        Button("click me") {
            detent = .medium
            showSheet.toggle()
        }
        .sheet(isPresented: $showSheet, content: {
            AddTagView(vm: TagsViewModel())
                .presentationDetents([.medium], selection: $detent)
        })
    }
}
