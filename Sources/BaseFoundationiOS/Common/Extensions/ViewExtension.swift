//
//  ViewExtension.swift
//  
//
//  Created by pablo borquez on 21/07/23.
//

import SwiftUI

extension View {
 
    public func onAsyncSubmit(action: @escaping AsyncHandler) -> some View {
        self.modifier(AsyncSubmitViewModifier(action: action))
    }
    
    // MARK: - alert
    
    public func presentAlert(withTitle title: String,
                             andMessage message: String,
                             isPresented: Binding<Bool>,
                             isCancelRequired: Bool = false,
                             okHandler: SimpleHandler? = nil) -> some View {
        self.modifier(AlertViewModifier(isPresented: isPresented,
                                        title: title,
                                        message: message,
                                        isCancelRequired: isCancelRequired,
                                        okHandler: okHandler))
    }
    
    public func presentAlert(withTitle title: String,
                             error: Error?,
                             isPresented: Binding<Bool>,
                             isCancelRequired: Bool = false,
                             okHandler: SimpleHandler? = nil) -> some View {
        self.presentAlert(withTitle: title,
                          andMessage: error as? String ?? "",
                          isPresented: isPresented,
                          isCancelRequired: isCancelRequired,
                          okHandler: okHandler)
    }
    
    public func pickerToolbar<DataSource: PickerToolbarType>(pickerOnChange: @escaping (DataSource) -> Void)  -> some View where DataSource.AllCases == (Array<DataSource>) {
        return self.modifier(PickerToolbarViewModifier(pickerOnChange: pickerOnChange))
    }
}
