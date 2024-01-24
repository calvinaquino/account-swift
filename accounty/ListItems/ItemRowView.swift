//
//  ItemRowView.swift
//  accounty
//
//  Created by Calvin Gonçalves de Aquino on 2024-01-22.
//

import SwiftUI
import SwiftData

struct ItemRowView: View {
    let item: Item
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    Text("Item description")
                        .font(.subheadline)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                Spacer()
                Image(systemName: item.isStocked ? "shippingbox.fill" : "shippingbox")
                    .onTapGesture {
                        item.isStocked.toggle()
                    }
            }
        }
        .foregroundStyle(.primary)
    }
}

#warning("Copy this model config setup to other previews, or setup a generic one in a shared file")
#Preview {
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container = try! ModelContainer(for: Item.self, configurations: config)
    let list = ShoppingList(name: "List")
    let item1 = Item(name: "Item 1 name", cost: 2.50, isStocked: true, isActive: true, list: list)
    let item2 = Item(name: "Item 2 name", cost: 12.50, isStocked: false, isActive: true, list: list)
    return List {
        ItemRowView(item: item1) {}
        ItemRowView(item: item2) {}
    }
}
