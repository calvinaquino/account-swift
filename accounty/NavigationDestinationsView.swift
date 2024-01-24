//
//  DestinationsView.swift
//  accounty
//
//  Created by Calvin Gonçalves de Aquino on 2024-01-08.
//

import SwiftUI

enum Destination: Hashable {
    case items(ShoppingList)
    case categories(ShoppingList)
    case editList(ShoppingList)
    case editItem(Item, ShoppingList)
    case editCategory(Category, ShoppingList)
}

#warning("cleanup this, edit views now appear in sheets.")
struct NavigationDestinationsView: View {
    let destination: Destination
    
    var body: some View {
        switch destination {
        case .items(let shoppingList):
            ListItemsView(list: shoppingList)
        case .categories(let shoppingList):
            CategoriesView(list: shoppingList)
        case .editList:
            Text("Not Yet Implemented")
        case .editItem(let item, let shoppingList):
            ItemEditView(item: item, list: shoppingList)
        case .editCategory(let category, let shoppingList):
            CategoryEditView(category: category, list: shoppingList)
        }
    }
}

//#Preview {
//    DestinationsView()
//}
