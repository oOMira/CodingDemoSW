//
//  ListViewControllerProtocol.swift
//  CodingDemoSW
//

import UIKit

protocol ListViewControllerBase: UITableViewDelegate, UITableViewDataSource where Self: UIViewController {
    associatedtype PageType: PageProtocol
    
    var tableView: LoadingTableView! { get }
    var firstPageURL: URL { get }
    var loading: Bool { get set }
    var pages: [PageType] { get set }

    init(firstPageURL: URL)

    func loadPage(url: URL) async -> CodableResultType<PageType>
    func loadPage(url: URL, completion: @escaping (CodableResultType<PageType>) -> Void)
}

extension ListViewControllerBase {
    var results: [PageType.Result] {
        pages.reduce(into: []) { $0.appendDistinctElements($1.results) }
    }

    var loading: Bool {
        get { tableView.loading }
        set { tableView.loading = newValue }
    }

    private func didTableViewReachedBottom() -> Bool {
        let height = tableView.frame.size.height
        let contentYOffset = tableView.contentOffset.y
        let distanceFromBottom = tableView.contentSize.height - contentYOffset
        let reachedBottom = distanceFromBottom < height
        return reachedBottom
    }
    
    func loadNextPageIfNeeded(completion: @escaping (CodableResultType<PageType>) -> Void) {
        guard didTableViewReachedBottom() else {
            return completion(failureWithDescription("not reached bottom yet"))
        }
        guard !loading else {
            return completion(failureWithDescription("already loading"))
        }
        guard let nextPageURL = results.isEmpty ? firstPageURL : pages.last?.next else {
            return completion(failureWithDescription("could not get URL"))
        }
        loading = true

        loadPage(url: nextPageURL) { [weak self] result in
            DispatchQueue.main.async {
                self?.loading = false
            }
            switch result {
            case .success(let page):
                self?.pages.append(page)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    completion(result)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(result)
            }
        }
    }
    
    func loadPage(url: URL, completion: @escaping (CodableResultType<PageType>) -> Void) {
        Task { [weak self] in
            guard let result = await self?.loadPage(url: url) else { return }
            completion(result)
        }
    }

    func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
    }
}

// - MARK: - Private Helper

private extension ListViewControllerBase {
    func failureWithDescription(_ description: String) -> CodableResultType<PageType> {
        let error = DefaultError(description: description)
        return .failure(error)
    }
}
