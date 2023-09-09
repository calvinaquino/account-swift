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
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
