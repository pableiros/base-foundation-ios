//
//  File.swift
//  
//
//  Created by pablo borquez on 11/02/24.
//

import Foundation

public protocol SearchableViewDelegate {
    associatedtype T: SearchableDelegate
    
    var searchText: String { get set }
    var contentArray: [T] { get }
}

extension SearchableViewDelegate {
    public var searchResults: [T] {
        var contentArray: [T]
        
        if self.searchText.isEmpty {
            contentArray = self.contentArray
        } else {
            contentArray = self.contentArray.filter {
                $0.isCandidateToFilter(searchText: self.searchText)
            }
        }
                
        return contentArray
    }
}
