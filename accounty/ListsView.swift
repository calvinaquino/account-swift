//
//  ContentView.swift
//  accounty
//
//  Created by Calvin Gonçalves de Aquino on 2023-09-08.
//

import SwiftUI
import SwiftData

struct ListsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var lists: [ShoppingList]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(lists) { list in
                    NavigationLink {
                        ListItemsView(list: list)
                    } label: {
                        Text(list.name)
                    }
                }
                .onDelete(perform: deleteItems)
            }

            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add List", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select a list")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = ShoppingList(name: "New list")
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(lists[index])
            }
        }
    }
}

#Preview {
    ListsView()
        .modelContainer(for: Item.self, inMemory: true)
}
