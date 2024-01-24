//
//  CategoriesView.swift
//  accounty
//
//  Created by Calvin Gonçalves de Aquino on 2024-01-08.
//

import SwiftUI
import SwiftData

struct CategoriesView: View {
    let list: ShoppingList
    
    var body: some View {
        CategoriesListingView(list: list)
    }
}

struct CategoriesListingView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var categories: [Category]
    let list: ShoppingList
    @State var editingCategory: Category?
    
    init(list: ShoppingList) {
        self.list = list
        let id = list.persistentModelID
        _categories = Query(filter: #Predicate { $0.list.persistentModelID == id })
    }
    
    var body: some View {
        List {
            ForEach(categories) { category in
                Button {
                    self.editingCategory = category
                } label: {
                    Text(category.name)
                        .font(.headline)
                }
                .foregroundStyle(.primary)
            }
            .onDelete(perform: deleteCategories)
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                EditButton()
                Button(action: addCategory) {
                    Label("Add Category", systemImage: "plus")
                }
            }
        }
        .sheet(item: $editingCategory) { category in
            NavigationView {
                CategoryEditView(category: category, list: self.list)
                    .navigationTitle(category.name)
                    .toolbar {
                        ToolbarItemGroup(placement: .topBarTrailing) {
                            Button {
                                self.editingCategory = nil
                            } label: {
                                Text("Done")
                            }
                        }
                    }
            }
        }
    }
    
    private func addCategory() {
        withAnimation {
            let newCategory = Category(name: "New Category", list: self.list)
            modelContext.insert(newCategory)
        }
    }
    
    private func deleteCategories(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(categories[index])
            }
        }
    }
}

#warning("Fix CategoriesView preview")
//#Preview {
//    CategoriesView()
//}
