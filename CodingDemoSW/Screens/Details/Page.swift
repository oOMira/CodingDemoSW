//
//  Page.swift
//  CodingDemoSW
//

import UIKit

typealias PageResultType = Codable & Equatable

// Helper to allow typed variables
protocol PageProtocol: Codable {
    associatedtype Result: PageResultType
    var next: URL? { get set }
    var previous: URL? { get set }
    var results: [Result] { get set }
}

class Page<Result: PageResultType>: PageProtocol {
    var next: URL?
    var previous: URL?
    var results: [Result]
}
