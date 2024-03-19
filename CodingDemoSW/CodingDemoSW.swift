//
//  CodingDemoSW.swift
//  CodingDemoSW
//

import SwiftUI

@main
struct CodingDemoSW: App, APIAccessible {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainCategoriesView()
            }
        }
        .modelContainer(for: [MainCategory.self])
    }
}
