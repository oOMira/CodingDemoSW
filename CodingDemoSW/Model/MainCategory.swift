//
//  MainCategory.swift
//  CodingDemoSW
//

import Foundation
import SwiftData

@Model
final class MainCategory: Codable {
    @Attribute(.unique) let date = Date()
    let peopleURL: URL
    let filmsURL: URL
    
    init(people: URL, films: URL) {
        peopleURL = people
        filmsURL = films
    }
    
    // MARK: - MainCategory+Codable

    enum CodingKeys: CodingKey {
        case people
        case films
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        peopleURL = try container.decode(URL.self, forKey: .people)
        filmsURL = try container.decode(URL.self, forKey: .films)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(filmsURL, forKey: .films)
        try container.encode(peopleURL, forKey: .people)
    }
}

