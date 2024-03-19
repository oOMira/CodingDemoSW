//
//  HTTPClientMock.swift
//  CodingDemoSW
//

import Foundation

/**
 The class mocking the network requests
 */
struct HTTPClientMock: API {
    static let shared = Self()
    
    /// The network delay in nanoseconds
    var networkDelay: UInt64 = 2 * 1000000000

    func fetch<T>(_ url: URL, type: T.Type) async -> CodableResultType<T> where T: Decodable, T: Encodable {
        .failure(.init(description: "fetch not implemented for HTTPClientMock"))
    }

    func fetchMainCategories() async -> CodableResultType<MainCategory> {
        await loadJSONResource("api", type: MainCategory.self)
    }
    
    func fetchPeopleDetails(url: URL) async -> CodableResultType<PersonPage> {
        let pageNumber = getPageNumberFromURL(url)
        return await loadJSONResource("api_people-page\(pageNumber)", type: PersonPage.self)
    }
    
    func fetchFilmsDetails(url: URL) async -> CodableResultType<FilmPage> {
        let pageNumber = getPageNumberFromURL(url)
        return await loadJSONResource("api_films-page\(pageNumber)", type: FilmPage.self)
    }
    
    func fetchFilm(url: URL) async -> CodableResultType<Film> {
        guard let elementNumber = getElemntNumberFromURL(url) else {
            return .failure(.init(description: "could not get film ID"))
        }
        return await loadJSONResource("api_films-1\(elementNumber)", type: Film.self)
    }

    // MARK: - Helper
    private func loadJSONResource<T: Codable>(_ resource: String, type: T.Type) async -> CodableResultType<T> {
        do {
            guard let path = Bundle.main.path(forResource: resource, ofType: "json") else {
                return .failure(.init(description: "could't get resource"))
            }
            let url = URL(filePath: path)
            let data = try Data(contentsOf: url)
            let parsedJSON = try JSONDecoder().decode(type.self, from: data)
            if networkDelay > 0 {
                try await Task.sleep(nanoseconds: .init(networkDelay))
            }
            return .success(parsedJSON)
        } catch {
            return .failure(.init(description: error.localizedDescription))
        }
    }
    
    private func getPageNumberFromURL(_ url: URL) -> String {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        return components?.queryItems?.first(where: { $0.name == "page" })?.value ?? "1"
    }
    
    private func getElemntNumberFromURL(_ url: URL) -> String? {
        URLComponents(url: url, resolvingAgainstBaseURL: true)?.url?.pathComponents.last
    }
}
