//
//  ItemEditView.swift
//  accounty
//
//  Created by Calvin Gonçalves de Aquino on 2024-01-08.
//

import SwiftUI
import SwiftData

struct ItemEditView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var item: Item
    let list: ShoppingList
    @Query private var categories: [Category]
    @State var editingCategory: Category?
    
    init(item: Item, list: ShoppingList) {
        self.item = item
        self.list = list
        let id = list.persistentModelID
        self._categories = Query(filter: #Predicate<Category> { $0.list.persistentModelID == id })
    }
    
    func newCategory() {
        withAnimation {
            let newCategory = Category(name: "New Category", list: self.list)
            modelContext.insert(newCategory)
            self.editingCategory = newCategory
        }
    }
    
    var body: some View {
        Form {
            TextField("Name", text: $item.name)
            TextEditor(text: $item.note)
            // I am not happy with this behaviour but it works.
            TextField("Cost", text: $item.cost)
                .keyboardType(.decimalPad)
            .keyboardType(.decimalPad)
            Toggle("Stocked", isOn: $item.isStocked)
            Toggle("Active", isOn: $item.isActive)
            Toggle("One time purchase", isOn: $item.once)
            //
            Section("Category") {
                Picker("Category", selection: $item.category) {
                    Text("None").tag(nil as Category?)
                    ForEach(categories) { category in
                        Text(category.name).tag(category as Category?)
                    }
                }
                Button {
                    newCategory()
                } label: {
                    Text("New Category")
                }

            }
        }
        .navigationTitle("Edit Item")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $editingCategory) { category in
            NavigationView {
                CategoryEditView(category: category, list: self.list)
                    .navigationTitle(category.name)
                    .toolbar {
                        ToolbarItemGroup(placement: .topBarTrailing) {
                            Button {
                                self.item.category = category
                                self.editingCategory = nil
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
    let item = Item.example()
    moc.mainContext.insert(ShoppingList.defaultExample)
    moc.mainContext.insert(item)
    return NavigationView {
        ItemEditView(item: item, list: .defaultExample)
            .modelContainer(moc)
    }
}
