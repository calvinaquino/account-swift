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
                    if !item.comment.isEmpty {
                        Text(item.comment)
                            .font(.subheadline)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                }
                Spacer()
                Image(systemName: item.isStocked ? "shippingbox.fill" : "shippingbox")
                    .onTapGesture {
                        item.isStocked.toggle()
                        if item.isStocked && item.once {
                            item.isActive = false
                        }
                    }
            }
        }
        .foregroundStyle(.primary)
    }
}

#Preview {
    let items = Item.examples()
    return List {
        ForEach(items) {
            ItemRowView(item: $0) {}
        }
    }
}
