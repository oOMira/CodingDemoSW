//
//  Array+Distinct.swift
//  CodingDemoSW
//

import Foundation

// Could be a custom collection
extension Array where Element: Equatable {
    /**
     Adds all distinct elements
     - Parameter elements: Array of elements that should be added
     - Returns: The array of the added distinct elements
     */
    @discardableResult
    mutating func appendDistinctElements(_ elements: [Element]) -> [Element] {
        elements.compactMap { appendDistinctElement($0) ? $0 : nil }
    }

    /**
     Adds element if it's  distinct
     - Parameter elements: Elements that should be added
     - Returns: A boolean indicating whether the element was distinct
     */
    @discardableResult
    mutating func appendDistinctElement(_ element: Element) -> Bool {
        guard !contains(element) else { return false }
        append(element)
        return true
    }
}
