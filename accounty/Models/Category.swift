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
#warning("Add an extension with some examples to be used in previews and tests")
