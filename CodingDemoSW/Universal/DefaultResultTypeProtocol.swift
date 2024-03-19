//
//  DefaultResultType.swift
//  CodingDemoSW
//

import Foundation

protocol DefaultResultTypeProtocol {
    associatedtype A: Any
    associatedtype B: Error
    static func success(_: A) -> Self
    static func failure(_: B) -> Self
}
