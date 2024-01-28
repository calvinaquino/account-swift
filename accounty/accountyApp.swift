//
//  accountyApp.swift
//  accounty
//
//  Created by Calvin Gonçalves de Aquino on 2023-09-08.
//

import SwiftUI
import SwiftData

@main
struct accountyApp: App {
    var sharedModelContainer: ModelContainer = DataProvider.mainContainer()

    var body: some Scene {
        WindowGroup {
            ListsView()
        }
        .modelContainer(sharedModelContainer)
    }
}
