//
//  Category.swift
//  accounty
//
//  Created by Calvin Gonçalves de Aquino on 2023-12-18.
//

import Foundation
import SwiftData

@Model
final class Category {
    var name: String = ""
    var list: ShoppingList
    @Relationship(inverse: \Item.category) var items: [Item] = []
    
    init(
        name: String = "",
        list: ShoppingList
    ) {
        self.name = name
        self.list = list
    }
}

extension Category {
    static func example(list: ShoppingList = .defaultExample) -> Category {
        return Category(name: "Category Example", list: list)
    }
    
    static func examples(list: ShoppingList = .defaultExample) ->  [Category] {
        return [
            Category(name: "Category Example 1", list: list),
            Category(name: "Category Example 2", list: list),
            Category(name: "Category Example 3", list: list),
            Category(name: "Category Example 4", list: list),
        ]
    }
}
