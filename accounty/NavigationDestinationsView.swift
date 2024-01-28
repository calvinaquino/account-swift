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
}

struct NavigationDestinationsView: View {
    let destination: Destination
    
    var body: some View {
        switch destination {
        case .items(let shoppingList):
            ListItemsView(list: shoppingList)
        case .categories(let shoppingList):
            CategoriesView(list: shoppingList)
        }
    }
}
