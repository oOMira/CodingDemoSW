//
//  DistinctArrayTests.swift
//  CodingDemoSWTests
//

import XCTest
@testable import CodingDemoSW

// Talk about unit tests of internal/public interfaces, metrics
final class DistinctArrayTests: XCTestCase {
    func testAppendDistinctElement() {
        var array = ["first", "second"]
        let result = array.appendDistinctElement("third")
        XCTAssertTrue(result)
    }
    
    func testAppendNonDistinctElement() {
        var array = ["first", "second"]
        let result = array.appendDistinctElement("second")
        XCTAssertFalse(result)
    }
    
    func testAppendDistinctElements() {
        var array = ["first", "second"]
        let distinctElements = array.appendDistinctElements(["third", "fourth"])
        XCTAssertEqual(distinctElements, ["third", "fourth"])
        XCTAssertEqual(array, ["first", "second", "third", "fourth"])
    }
    
    func testAppendNonDistinctElements() {
        var array = ["first", "second"]
        let distinctElements = array.appendDistinctElements(["first", "third"])
        XCTAssertEqual(distinctElements, ["third"])
        XCTAssertEqual(array, ["first", "second", "third"])
    }
}
