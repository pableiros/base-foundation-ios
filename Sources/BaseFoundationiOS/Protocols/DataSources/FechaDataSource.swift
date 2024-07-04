//
//  FechaDataSource.swift
//
//
//  Created by pablo borquez on 29/06/24.
//

import Foundation

public protocol FechaDataSource {
    var fecha: Date { get set }
}

extension FechaDataSource {
    public mutating func setFecha(from dict: [String: Any]) {
        let fecha: String = dict.get(for: "fecha")
        self.fecha = fecha.toDate() ?? Date()
    }
}
