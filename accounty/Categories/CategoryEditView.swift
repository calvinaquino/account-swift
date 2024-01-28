//
//  CategoryEditView.swift
//  accounty
//
//  Created by Calvin Gonçalves de Aquino on 2024-01-08.
//

import SwiftUI
import SwiftData

struct CategoryEditView: View {
    @Bindable var category: Category
    let list: ShoppingList
    @State var editingItem: Item?
    var body: some View {
        Form {
            TextField("Name", text: $category.name)
            Section("Items") {
                List {
                    ForEach(category.items) { item in
                        ItemRowView(item: item) {
                            self.editingItem = item
                        }
                    }
                }
            }
        }
        .navigationTitle("Edit Item")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $editingItem) { item in
            NavigationView {
                ItemEditView(item: item, list: self.list)
                    .navigationTitle(item.name)
                    .toolbar {
                        ToolbarItemGroup(placement: .topBarTrailing) {
                            Button {
                                self.editingItem = nil
                            } label: {
                                Text("Done")
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    let moc = DataProvider.previewContainer()
    let category = Category.example()
    category.items = Item.examples()
    moc.mainContext.insert(ShoppingList.defaultExample)
    moc.mainContext.insert(category)
    for item in category.items {
        moc.mainContext.insert(item)
    }
    return NavigationView {
        CategoryEditView(category: category, list: .defaultExample)
            .modelContainer(moc)
    }
}
