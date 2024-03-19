//
//  CodeableResultType.swift
//  CodingDemoSW
//

import Foundation

/**
 A value that represents either a success or a failure, including a Codable associated value for success case
 */
enum CodableResultType<T:Codable>: DefaultResultTypeProtocol {
    case success(T)
    case failure(DefaultError)
}
