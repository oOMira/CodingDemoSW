//
//  Film.swift
//  CodingDemoSW
//

import Foundation

struct Film: Codable {
    let title: String
}

extension Film: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.title == rhs.title
    }
}
