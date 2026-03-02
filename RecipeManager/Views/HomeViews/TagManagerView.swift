//
//  TagManagerView.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 17/09/24.
//

import SwiftUI
import SwiftData

struct TagManagerView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query var allTags: [TagModel]
    @State var selectedTag = TagModel(title: "unselected", color: .blue)
    
    @State private var showSheet: Bool = false
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(allTags) { tag in
                    TagView(tag: tag)
                        .swipeActions(allowsFullSwipe: false) {
                            Button {
                                selectedTag = tag
                                showAlert = true
                            } label: {
                                Text("Delete")
                            }
                            .tint(.red)
                        }
                }
                .alert("Delete \"\(selectedTag.title)\" tag? It will completely disappear in all recipes",
                       isPresented: $showAlert,
                       presenting: selectedTag) { tag in
                    confirmationDeleteButton
                }
            }
            .navigationTitle("Recipe tags")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) { addButton }
            }
            .sheet(isPresented: $showSheet) {
                AddTagView().presentationDetents([.medium, .large])
            }
        }
    }
    
    var addButton: some View {
        Button {
            showSheet.toggle()
        } label: {
            Image(systemName: "plus")
        }
    }
    
    var confirmationDeleteButton: some View {
        Button("delete", role: .destructive) {
            withAnimation {
                TagsDataService.delete(selectedTag, context: modelContext)
            }
        }
    }
    
    func showDeleteAlert() { showAlert = true }
    
}

#Preview {
    TagManagerView()
        .modelContainer(previewContainer)
}
