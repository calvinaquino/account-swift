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

#warning("Add an extension with some examples to be used in previews and tests")
