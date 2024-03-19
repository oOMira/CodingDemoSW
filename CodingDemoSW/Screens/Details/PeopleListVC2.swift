//
//  PeopleListVC.swift
//  CodingDemoSW
//
//  Created by Mira Risse on 01.09.23.
//

import UIKit

final class PeopleListVC: UIViewController, DetailsListVC, FilmsTappedDelegate {
    init(firstPageURL: URL) {
        self.firstPageURL = firstPageURL
        super.init(nibName: "PeopleDetailsVC", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var loading: Bool = false
    let firstPageURL: URL
    
    @IBOutlet weak var tableView: UITableView!
    var pages = [Page<Person>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "PersonDetailsTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "defaultCell")
        setup()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath) as? PersonDetailsTableViewCell
        let result = results[indexPath.row]
        cell?.person = result
        cell?.filmsDelegate = self
        return cell ?? .init()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll(scrollView: scrollView)
    }
}
