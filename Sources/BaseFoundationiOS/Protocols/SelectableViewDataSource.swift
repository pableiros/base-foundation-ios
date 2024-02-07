//
//  SelectableViewDataSource.swift
//  
//
//  Created by pablo borquez on 06/02/24.
//

import SwiftUI

public protocol SelectableViewDataSource: View {
    associatedtype ContainerType
    
    init(_ containerSelected: ContainerType?, successHandler: @escaping (ContainerType) -> Void)
}
