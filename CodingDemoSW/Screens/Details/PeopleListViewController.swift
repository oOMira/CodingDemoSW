//
//  PeopleListViewController.swift
//  CodingDemoSW
//

import UIKit

final class PeopleListViewController: UIViewController, ListViewControllerBase, APIAccessible {
    @IBOutlet weak var tableView: LoadingTableView!
    var pages = [API.PersonPage]()
    let firstPageURL: URL
    
    init(firstPageURL: URL) {
        self.firstPageURL = firstPageURL
        super.init(nibName: "PeopleListViewController", bundle: nil)
        title = "People"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        registerCells()
        loadNextPageIfNeeded { _ in }
    }

    func registerCells() {
        let cellNib = UINib(nibName: "PersonDetailsTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "PersonDetailsCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonDetailsCell", for: indexPath) as! PersonDetailsTableViewCell
        cell.person = results[indexPath.row]
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        loadNextPageIfNeeded { _ in }
    }
    
    func loadPage(url: URL) async -> CodableResultType<API.PersonPage> {
        await api.fetchPeopleDetails(url: url)
    }
}
