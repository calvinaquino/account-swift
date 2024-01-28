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
#warning("Do we really need a UUID?")
//    @Attribute(.unique) var identifier: UUID
    var name: String
#warning("Add a description field, but since we cant reuse the word description, maybe itemDescription?")
    var cost: Float
    var isStocked: Bool
    var once: Bool // when purchased, deactivates item
    var isActive: Bool
    var timestamp: Date
    
    var category: Category?
    var list: ShoppingList
    var tags: [String] = []
    
    init(
        name: String = "",
        cost: Float = 0.00,
        isStocked: Bool = false,
        once: Bool = false,
        isActive: Bool = true,
        category: Category? = nil,
        list: ShoppingList,
        tags: [String] = []
    ) {
        self.name = name
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
            cost: .random(in: 0...100),
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
