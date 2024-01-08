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
