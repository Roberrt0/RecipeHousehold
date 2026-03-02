//
//  AddTagView.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 26/09/24.
// "Add an item ✏️"

import SwiftUI

struct AddTagView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    init() {
    }
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    @State var textFieldText: String = ""
    @State var colorSelected: TagColor = .blue
    
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
            ForEach(TagColor.allCases, id: \.self) { color in
                ZStack {
                    Circle()
                        .fill(color.swiftUIColor)
                        .frame(width: 50)
                        .padding(10)
                        .onTapGesture {
                            colorSelected = color
                        }
                    
                    if color == colorSelected {
                        Circle()
                            .stroke(color.swiftUIColor, style: StrokeStyle(lineWidth: 5))
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
        // validate
        if !TagsDataService.validateTitle(title: textFieldText) {
            alertTitle = "Invalid text!"
            alertMessage = "your text should at least have 3 characters 🤓"
            showAlert.toggle()
            return
        }
        
        // pass to the viewmodel and close popup
        TagsDataService.add(title: textFieldText, color: colorSelected, context: modelContext)
        presentationMode.wrappedValue.dismiss()
    }
}

// MARK: Xcode Preview

#Preview {
    NavigationStack {
        AddTagView()
    }
    .modelContainer(previewContainer)
}

// used for the preview
struct AddViewSheetTest: View {
    
    @State private var showSheet: Bool = false
    @State private var detent: PresentationDetent = .medium
    
    var body: some View {
        Button("click me") {
            detent = .medium
            showSheet.toggle()
        }
        .sheet(isPresented: $showSheet, content: {
            AddTagView()
                .presentationDetents([.medium], selection: $detent)
        })
    }
}
