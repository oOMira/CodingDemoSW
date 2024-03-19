//
//  DetailsListViewControllerRepresentable.swift
//  CodingDemoSW
//

import SwiftUI

struct DetailsListViewControllerRepresentable<T: ListViewControllerBase>: UIViewControllerRepresentable {
    let firstPageURL: URL
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        T(firstPageURL: firstPageURL)
    }
}
