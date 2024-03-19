//
//  PersonDetailsTableViewCell.swift
//  CodingDemoSW
//

import UIKit
import Accessibility

final class PersonDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!

    var person: Person? {
        didSet {
            guard let person else { return }
            titleLabel.text = person.name
            genderLabel.text = "Gender: \(person.gender)"
            heightLabel.text = "Height: \(person.height)"
            massLabel.text = "Mass: \(person.mass)"
        }
    }
}

// MARK: - PersonDetailsTableViewCell+AXCustomContentProvider

extension PersonDetailsTableViewCell: AXCustomContentProvider {
    override var accessibilityLabel: String? {
        get { person?.name }
        set { }
    }
    
    var accessibilityCustomContent: [AXCustomContent]! {
        get {
            guard let person = person else { return .init() }
            return [
                .init(label: "Gender", value: person.gender),
                .init(label: "Height", value: person.height),
                .init(label: "Mass", value: person.mass)
            ]
            
        }
        set(accessibilityCustomContent) { }
    }
}
