//
//  ArrayExtension.swift
//
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation

extension Array {
    public func toJSONText() -> String {
        var jsonText: String = ""
        
        if let theJSONData = try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted]) {
            jsonText = String(data: theJSONData, encoding: .utf8)!
        }
        
        return jsonText.replacingOccurrences(of: #"\/"#, with: "/")
    }
}

extension Array where Element: Copying {
    public func clone() -> Array {
        var copiedArray = Array<Element>()
        
        for element in self {
            copiedArray.append(element.copy())
        }
        
        return copiedArray
    }
}

extension Sequence where Element: Hashable {
    public func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}

extension Array where Element: FechaDataSource {
    public func sortDesc() -> Array {
        self.sorted { $0.fecha > $1.fecha }
    }
}

extension Array where Element: Sequence {
    public func joined() -> Array<Element.Element> {
        return self.reduce([], +)
    }
}

extension Array where Element: UUIDDataSource {
    public func excluding(_ itemsToExclude: [Element]) -> [Element] {
        let filteredArray: [Element]
        
        if itemsToExclude.count <= 3 {
            filteredArray = self.filter { item in
                !itemsToExclude.contains { $0.id == item.id }
            }
        } else {
            let excludeIDs = Set(itemsToExclude.map { $0.id })
            filteredArray = self.filter { !excludeIDs.contains($0.id) }
        }
        
        return filteredArray
    }
}
