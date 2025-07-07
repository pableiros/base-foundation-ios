//
//  CollectionExtension.swift
//  BaseFoundationiOS
//
//  Created by pablo borquez on 03/07/25.
//

import Foundation

extension Collection {
    public subscript(at index: Index) -> Element? {
        self.indices.contains(index) ? self[index] : nil
    }
}
