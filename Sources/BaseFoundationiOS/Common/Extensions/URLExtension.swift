//
//  URLExtension.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation

extension URL {
    public func appendQuery(parameters: [String: String]?) -> URL {
        guard let parameters = parameters,
              let urlComponents = NSURLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return self
        }

        var mutableQueryItems: [NSURLQueryItem] = [NSURLQueryItem]()

        if let urlQueryItems: [NSURLQueryItem] = urlComponents.queryItems as [NSURLQueryItem]? {
            mutableQueryItems = urlQueryItems
        }

        let urlQueryItemArray: [NSURLQueryItem] = parameters.map({ (key: String, value: String) in
            return NSURLQueryItem(name: key, value: value)
        })

        mutableQueryItems.append(contentsOf: urlQueryItemArray)
        urlComponents.queryItems = mutableQueryItems as [URLQueryItem]?
        
        return urlComponents.url!
    }
}
