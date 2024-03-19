//
//  Person.swift
//  CodingDemoSW
//

import Foundation

struct Person: Codable {
    let name: String
    let gender: String
    let height: String
    let mass: String
    let films: [URL]?
}

extension Person: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.name == rhs.name
    }
}
