//
//  TagManagerView.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 17/09/24.
//

import SwiftUI

struct TagManagerView: View {
    
    @StateObject var vm: TagsViewModel = TagsViewModel()
    @State var selectedTag = TagModel(title: "unselected", colorName: "none")
    
    @State private var showSheet: Bool = false
    @State private var showAlert: Bool = false
    
    var body: some View {
        List {
            ForEach(vm.tags) { tag in
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
            .onMove(perform: vm.move)
            .alert("Delete \"\(selectedTag.title)\" tag? It will completely disappear in all recipes",
                   isPresented: $showAlert,
                   presenting: selectedTag) { tag in
                confirmationDeleteButton
            }
        }
        .navigationTitle("Your Tags")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) { addButton }
            ToolbarItem(placement: .topBarTrailing) { EditButton() }
        }
        .sheet(isPresented: $showSheet) {
            AddTagView(vm: self.vm).presentationDetents([.medium, .large])
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
                vm.delete(selectedTag)
            }
        }
    }
    
    func showDeleteAlert() { showAlert = true }
    
}

#Preview {
    NavigationStack {
        TagManagerView()
    }
}
