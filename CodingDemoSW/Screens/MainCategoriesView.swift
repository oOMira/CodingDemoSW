//
//  MainCategoriesView.swift
//  CodingDemoSW
//

import SwiftUI
import SwiftData

struct MainCategoriesView: View, APIAccessible {
    @Query() private var categories: [MainCategory]
    @Environment(\.modelContext) var modelContext
    @State private var didLoad = false
    
    var body: some View {
        VStack {
            // TODO: Error state not handled
            if let categories = categories.first {
                CategoriesList(categories: categories)
            } else {
                LoadingView()
            }
            Text("Data from https://swapi.dev")
        }
        .navigationTitle("Categories")
        .task {
            // TODO: Flag is not the best solution, not properly aborted when showing next view while executing
            guard !didLoad else { return }
            await updateCategory()
        }
    }
    
    private func updateCategory() async {
        let result = await api.fetchMainCategories()
        switch result {
        case .failure(let error): print(error.localizedDescription)
        case .success(let category):
            categories.forEach { modelContext.delete($0) }
            modelContext.insert(category)
            didLoad = true
        }
    }
}

private struct CategoriesList: View {
    let categories: MainCategory
    
    var body: some View {
        List {
            NavigationLink("Films") {
                DetailsListViewControllerRepresentable<FilmsListViewController>(firstPageURL: categories.filmsURL)
                    .navigationTitle("Films")
            }
            NavigationLink("People") {
                DetailsListViewControllerRepresentable<PeopleListViewController>(firstPageURL: categories.peopleURL)
                    .navigationTitle("People")
            }
        }
    }
}

private struct LoadingView: View {
    var body: some View {
        ProgressView()
            .controlSize(.extraLarge)
    }
}
