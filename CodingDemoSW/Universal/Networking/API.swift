//
//  API.swift
//  CodingDemoSW
//

import Foundation

protocol API {
    func fetch<T: Codable>(_ url: URL, type: T.Type) async -> CodableResultType<T>
    func fetchMainCategories() async -> CodableResultType<MainCategory>
    func fetchPeopleDetails(url: URL) async -> CodableResultType<PersonPage>
    func fetchFilmsDetails(url: URL) async -> CodableResultType<FilmPage>
    func fetchFilm(url: URL) async -> CodableResultType<Film>
}

extension API {
    typealias PersonPage = Page<Person>
    typealias FilmPage = Page<Film>

    func fetchMainCategories() async -> CodableResultType<MainCategory> {
        await fetch(.baseAPI, type: MainCategory.self)
    }

    func fetchPeopleDetails(url: URL) async -> CodableResultType<PersonPage> {
        await fetch(url, type: PersonPage.self)
    }
    
    func fetchFilmsDetails(url: URL) async -> CodableResultType<FilmPage> {
        await fetch(url, type: FilmPage.self)
    }
    
    func fetchFilm(url: URL) async -> CodableResultType<Film> {
        await fetch(url, type: Film.self)
    }
}
