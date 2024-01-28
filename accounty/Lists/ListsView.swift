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
    @State private var appState = AppState()
    @State private var loaded = false

    var body: some View {
        NavigationStack(path: $appState.path) {
            List {
                ForEach(lists) { list in
                    NavigationLink(value: Destination.items(list)) {
                        Text(list.name)
                            .font(.headline)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add List", systemImage: "plus")
                    }
                }
            }
            .navigationDestination(for: Destination.self) { destination in
                NavigationDestinationsView(destination: destination)
            }
        }
        .task {
            withAnimation {
                appState.loadCachedList(context: self.modelContext)
                self.loaded = true
            }
        }
        .environment(appState)
        .overlay {
            if !loaded {
                ZStack {
                    Color(UIColor.systemBackground)
                    ProgressView()
                }
                .ignoresSafeArea()
            }
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

@Observable
final class AppState {
    var path: [Destination] = []
    
    func loadCachedList(context: ModelContext) {
        guard !PreviewHelper.isPreview else { return }
        if let data = UserDefaults.standard.data(forKey: "selectedList") {
            let listId = try! JSONDecoder().decode(ShoppingList.ID.self, from: data)
            if let list = context.model(for: listId) as? ShoppingList {
                self.path = [.items(list)]
            }
        }
    }
}

extension AppState {
    static func example() -> AppState {
        AppState()
    }
}

#Preview {
    let moc = DataProvider.previewContainer()
    let lists = ShoppingList.examples()
    for list in lists {
        moc.mainContext.insert(list)
    }

    return NavigationStack {
        ListsView()
            .modelContainer(moc)
    }
    
}
