//
//  DefaultError.swift
//  CodingDemoSW
//

import Foundation

struct DefaultError: Error {
    let description: String
}

// MARK: - DefaultError+LocalizedError

extension DefaultError: LocalizedError {
    var errorDescription: String? {
        description
    }
}
