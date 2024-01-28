//
//  DataProvider.swift
//  accounty
//
//  Created by Calvin Gonçalves de Aquino on 2024-01-27.
//

import Foundation
import SwiftData

enum DataProvider {
    static func mainContainer(inMemory: Bool = false) -> ModelContainer {
        let schema = Schema([
            ShoppingList.self,
            Category.self,
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: inMemory)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    static func previewContainer() -> ModelContainer {
        return mainContainer(inMemory: true)
    }
}
