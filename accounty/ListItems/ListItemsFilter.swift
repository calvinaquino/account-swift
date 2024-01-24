//
//  ListItemsFilter.swift
//  accounty
//
//  Created by Calvin Gonçalves de Aquino on 2024-01-24.
//

import SwiftUI
import SwiftData

struct ListingCategory: Identifiable {
    let id: PersistentIdentifier
    let name: String
    let items: [Item]
}

struct ListitemsFilter<Content: View>: View {
    typealias ListItemsFilterContent = ([Item], [ListingCategory]) -> Content
    @Query private var items: [Item]
    @Query private var categories: [Category]
    @Binding var searchText: String
    @ViewBuilder var content: ListItemsFilterContent
    
    private var uncategorizedItems: [Item] {
        items.filter { $0.category == nil }
    }
    
    private var listingCategories: [ListingCategory] {
        var _listingCategories: [ListingCategory] = []
        for category in categories {
            let items = items.filter { $0.category == category }
            if !items.isEmpty {
                _listingCategories.append(ListingCategory(id: category.persistentModelID, name: category.name, items: items))
            }
        }
        return _listingCategories
    }
    
    init(list: ShoppingList, searchText: Binding<String>, content: @escaping ListItemsFilterContent) {
        self.content = content
        self._searchText = searchText
        let id = list.persistentModelID
        let search = searchText.wrappedValue
        self._items = Query(filter: #Predicate<Item> {
            $0.list.persistentModelID == id &&
            search.isEmpty ? true : $0.name.localizedStandardContains(search)
        })
        
        self._categories = Query(filter: #Predicate<Category> {
            $0.list.persistentModelID == id
        })
    }
    
    var body: some View {
        self.content(uncategorizedItems, listingCategories)
    }
}

#warning("Fix ListItemsFilter preview")
//#Preview {
//    ListItemsFilter()
//}
