//
//  FilmsListViewController.swift
//  CodingDemoSW
//

import UIKit

final class FilmsListViewController: UIViewController, ListViewControllerBase, APIAccessible {
    @IBOutlet weak var tableView: LoadingTableView!

    let firstPageURL: URL
    var pages = [API.FilmPage]()
    
    init(firstPageURL: URL) {
        self.firstPageURL = firstPageURL
        super.init(nibName: "FilmsListViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        registerCells()
        loadNextPageIfNeeded() { _ in }
    }

    func registerCells() {
        let nib = UINib(nibName: "FilmDetailsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "filmDetailsTableViewCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filmDetailsTableViewCell", for: indexPath) as! FilmDetailsTableViewCell
        cell.viewModel.setFilm(results[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        loadNextPageIfNeeded() { _ in }
    }
    
    func loadPage(url: URL) async -> CodableResultType<Page<Film>> {
        await api.fetchFilmsDetails(url: url)
    }
}
