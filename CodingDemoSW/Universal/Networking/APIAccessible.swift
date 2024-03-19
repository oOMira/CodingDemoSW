//
//  APIAccessible.swift
//  CodingDemoSW
//

import Foundation

protocol APIAccessible {
    var api: API { get }
}

extension APIAccessible {
    var api: API {
        #if DEBUG
        if ProcessInfo.processInfo.arguments.contains("isUITesting") {
            return HTTPClientMock.shared
        } else if FeatureFlags.mockData {
            return HTTPClientMock.shared
        } else {
            return HTTPClient.shared
        }
        #else
        return HTTPClient()
        #endif
    }
}
