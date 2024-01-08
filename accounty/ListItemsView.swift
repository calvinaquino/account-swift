//
//  ListItemsView.swift
//  accounty
//
//  Created by Calvin Gonçalves de Aquino on 2023-12-18.
//

import SwiftUI
import SwiftData

struct ListItemsView: View {
    @Environment(\.modelContext) private var modelContext
    let list: ShoppingList
    @State var searchText = ""

    var body: some View {
        ListItemsListingView(list: self.list, searchText: searchText)
            .searchable(text: $searchText)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                ToolbarItem {
                    Button(action: addCategory) {
                        Label("Add Category", systemImage: "folder")
                    }
                }
            }
            .navigationTitle(list.name)
            .navigationBarTitleDisplayMode(.inline)
    }
    
    private func addItem() {
        withAnimation {
            let randomInt = Int.random(in: 1..<9000)
            let newItem = Item(name: "item \(randomInt)", list: list)
            modelContext.insert(newItem)
        }
    }
    
    private func addCategory() {
        withAnimation {
            let randomInt = Int.random(in: 1..<9000)
            let newItem = Category(name: "Category \(randomInt)", list: list)
            modelContext.insert(newItem)
        }
    }
}

private struct ListingCategory: Identifiable {
    let id: String
    let name: String
    let items: [Item]
}

private struct ListItemsListingView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @Query private var catrgories: [Category]
    
    private var uncategorizedItems: [Item] {
        items.filter { $0.category == nil }
    }
    
    private var listingCategories: [ListingCategory] {
        var _listingCategories: [ListingCategory] = []
        for category in catrgories {
            let items = items.filter { $0.category == category }
            if !items.isEmpty {
                _listingCategories.append(ListingCategory(id: category.persistentModelID.entityName, name: category.name, items: items))
            }
        }
        return _listingCategories
    }
    
    init(list: ShoppingList, searchText: String) {
        let id = list.persistentModelID
        self._items = Query(filter: #Predicate<Item> {
            $0.list.persistentModelID == id &&
            searchText.isEmpty ? true : $0.name.localizedStandardContains(searchText)
        })
        
        self._catrgories = Query(filter: #Predicate<Category> {
            $0.list.persistentModelID == id
        })
    }
    
    var body: some View {
        List {
            ForEach(uncategorizedItems) { item in
                Text(item.name)
            }
                .onDelete(perform: deleteUncategorizedItems)
            ForEach(listingCategories) { category in
                Section(header: Text(category.name)) {
                    ForEach(category.items) { item in
                        Text(item.name)
                    }
                        .onDelete(perform: deleteCategorizedItems)
                }
            }
        }
    }
    
    private func deleteUncategorizedItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(uncategorizedItems[index])
            }
        }
    }
    
    private func deleteCategorizedItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                print(index)
//                modelContext.delete(listingCategories[index].items[])
            }
        }
    }
}

private extension ListItemsListingView {
    @Observable
    class ViewModel {
        var list: ShoppingList
        
        var uncategorizedItems: [Item] = []
        var categories: [Category] = []
        
        let uncategorizedItemsFetchDescriptor: FetchDescriptor<Item>!
        let categoriesFetchDescriptor: FetchDescriptor<Category>!
        
        init(list: ShoppingList) {
            self.list = list
            let id = list.persistentModelID
            
            self.uncategorizedItemsFetchDescriptor = FetchDescriptor(predicate: #Predicate<Item> {
                $0.list.persistentModelID == id && $0.category == nil
            })
            
            self.categoriesFetchDescriptor = FetchDescriptor(predicate: #Predicate<Category> {
                $0.list.persistentModelID == id
            })
        }
        
        func fetch(context: ModelContext) {
            do {
                self.uncategorizedItems = try context.fetch(uncategorizedItemsFetchDescriptor)
                self.categories = try context.fetch(categoriesFetchDescriptor)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        func addItem(context: ModelContext) {
            withAnimation {
                let newItem = Item(name: "New item", list: list)
                context.insert(newItem)
                self.uncategorizedItems.append(newItem)
            }
        }
    }
}

#Preview {
    ListsView()
        .modelContainer(for: Item.self, inMemory: true)
}
