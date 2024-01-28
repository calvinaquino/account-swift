//
//  ShoppingList.swift
//  accounty
//
//  Created by Calvin Gonçalves de Aquino on 2023-12-18.
//

import Foundation
import SwiftData

@Model
final class ShoppingList {
    var name: String
    @Relationship(inverse: \Category.list) var categories: [Category] = []
    @Relationship(inverse: \Item.list) var items: [Item] = []
    var tags: [String] = []
    
    init(name: String = "") {
        self.name = name
    }
}

extension ShoppingList {
    // Useful for creating child models without worrying about passing a list
    static var defaultExample = example()
    
    static func example() -> ShoppingList {
        return ShoppingList(name: "Example List")
    }
    
    static func examples() -> [ShoppingList] {
        return [
            ShoppingList(name: "Example List 1"),
            ShoppingList(name: "Example List 2"),
            ShoppingList(name: "Example List 3"),
            ShoppingList(name: "Example List 4"),
        ]
    }
}
