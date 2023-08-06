//
//  PickerToolbarViewModifier.swift
//  
//
//  Created by pablo borquez on 06/08/23.
//

import SwiftUI

public struct PickerToolbarViewModifier<DataSource: PickerToolbarType>: ViewModifier where DataSource.AllCases == Array<DataSource> {
    let pickerOnChange: (DataSource) -> Void
    
    @State private var valueSelected = DataSource.firstCase
    
    public init(pickerOnChange: @escaping ( DataSource) -> Void) {
        self.pickerOnChange = pickerOnChange
    }
    
    public func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Picker("", selection: $valueSelected) {
                        ForEach(DataSource.allCases) { dataSource in
                            Text(dataSource.value)
                                .tag(dataSource.id)
                        }
                    }
                    .onChange(of: self.valueSelected) { valueSelected in
                        self.pickerOnChange(valueSelected)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
    }
}
