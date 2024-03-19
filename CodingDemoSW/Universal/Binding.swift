//
//  Binding.swift
//  CodingDemoSW
//

import Foundation

class Binding<T> {
    var observer: ((T?) -> ())?

    var value: T? {
        didSet { observer?(value) }
    }
    
    func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
}
