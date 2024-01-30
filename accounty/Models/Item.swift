//
//  Item.swift
//  accounty
//
//  Created by Calvin Gonçalves de Aquino on 2023-09-08.
//

import Foundation
import SwiftData

@Model
final class Item {
    var name: String
    var note: String
    var cost: String
    var isStocked: Bool
    var once: Bool // when purchased, deactivates item
    var isActive: Bool
    var timestamp: Date
    
    var category: Category?
    var list: ShoppingList
    var tags: [String] = []
    
    init(
        name: String = "",
        note: String = "",
        cost: String = "0.00",
        isStocked: Bool = false,
        once: Bool = false,
        isActive: Bool = true,
        category: Category? = nil,
        list: ShoppingList,
        tags: [String] = []
    ) {
        self.name = name
        self.note = note
        self.cost = cost
        self.isStocked = isStocked
        self.once = once
        self.isActive = isActive
        self.category = category
        self.list = list
        self.timestamp = Date()
    }
}

extension Item {
    static func example(name: String = "Example Item" ,list: ShoppingList = .defaultExample, category: Category? = nil) -> Item {
        return Item(
            name: name,
            note: "a comment",
            cost: Float.random(in: 0...30).asString,
            isStocked: .random(),
            once: .random(),
            isActive: .random(),
            category: category,
            list: list,
            tags: ["hot", "cold", "big", "small"]
        )
    }
    
    static func examples(list: ShoppingList = .defaultExample, category: Category? = nil) ->  [Item] {
        return [
            example(name: "Item 1", list: list, category: category),
            example(name: "Item 2", list: list, category: category),
            example(name: "Item 3", list: list, category: category),
            example(name: "Item 4", list: list, category: category),
        ]
    }
}
