//
//  NavigationUITest.swift
//  CodingDemoSWUITests
//

import XCTest

final class NavigationUITest: XCTestCase {
    func testExample() throws {
        let app = XCUIApplication()
        app.launchArguments.append("isUITesting")
        app.launch()
    }
}
