//
//  Networking.swift
//  CodingDemoSW
//

import Foundation

/**
 The class handling the network requests
 */
struct HTTPClient: API {
    static let shared = Self()

    /**
     Performs a http get request on a given url and parses the data to a certain type
     - Parameter url: The endpoint to perform the request on
     - Parameter type: The type the data should be parsed to
     - Returns: The result containing the parsed data or an error
     */
    func fetch<T: Codable>(_ url: URL, type: T.Type) async -> CodableResultType<T> {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let parsedJSON = try JSONDecoder().decode(type, from: data)
            return .success(parsedJSON)
        } catch {
            return .failure(.init(description: error.localizedDescription))
        }
    }
}
