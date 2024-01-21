//
//  SearchableDelegate.swift
//
//
//  Created by pablo borquez on 20/01/24.
//

import Foundation

public protocol SearchableDelegate {
    func isCandidateToFilter(searchText: String) -> Bool
}

extension SearchableDelegate {
    public func isCandidateToFilter(searchText: String) -> Bool {
        fatalError("Override required")
    }

    public func contains(text: String?, searchText: String) -> Bool {
        return text?.range(of: searchText, options: .caseInsensitive) != nil
    }
}
