//
//  LoadingTableView.swift
//  CodingDemoSW
//

import UIKit

// Probably not a perfect solution but sufficient for a demo
final class LoadingTableView: UITableView {
    var loading: Bool = false {
        didSet { tableFooterView = loading ? loadingView : nil }
    }
    
    lazy var loadingView: UIView = {
        let backgroundView = UITableViewHeaderFooterView()
        backgroundView.frame.size.height = 100
        let activityIndicatorView = UIActivityIndicatorView()
        backgroundView.addSubview(activityIndicatorView)
        activityIndicatorView.style = .large
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).activate()
        activityIndicatorView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).activate()
        activityIndicatorView.startAnimating()
        return backgroundView
    }()
}
