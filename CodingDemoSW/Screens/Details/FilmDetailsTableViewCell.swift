//
//  FilmTableViewCell.swift
//  CodingDemoSW
//

import UIKit

final class FilmDetailsTableViewCell: UITableViewCell {
    var viewModel = ViewModel()

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewModel.title.bind { [weak nameLabel] name in
            DispatchQueue.main.async {
                nameLabel?.text = name
            }
        }
    }
}

// MARK: - ViewModel

extension FilmDetailsTableViewCell {
    class ViewModel {
        var title = Binding<String>()
        
        func setFilm(_ film: Film) {
            title.value = film.title
        }
    }
}
