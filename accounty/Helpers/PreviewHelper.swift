//
//  PreviewHelper.swift
//  accounty
//
//  Created by Calvin Gonçalves de Aquino on 2024-01-27.
//

import Foundation

enum PreviewHelper {
    static var isPreview: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
