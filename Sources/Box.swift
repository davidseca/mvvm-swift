//
//  Box.swift
//  MVVMSwift
//
//  Created by David Seca on 19.07.22.
//  Copyright © 2022 David Seca. All rights reserved.
//

import Foundation

/// Class to support observing to  notify observers that a value has changed.
final class Box<T> {

    /// Listener Generic Type
    typealias Listener = (T) -> Void

    /// Listener to be notified of any value update
    var listener: Listener?

    /// Generic value itself to be observed
    var value: T {
        didSet {
            listener?(value)
        }
    }

    /// Constructor
    /// - parameters:
    ///    - value: Value to be observed
    init(_ value: T) {
      self.value = value
    }

    /// Subscribe a listener for being notified on value changes
    /// - parameters:
    ///    - value: Listener to be notified of any value update
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }

}
