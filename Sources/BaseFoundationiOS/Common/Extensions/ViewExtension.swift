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
    
    public func setMaxFrame(alignment: Alignment = .topLeading) -> some View {
        self.modifier(MaxFrameViewModifier(alignment: alignment))
    }
    
    public func pickerToolbar<DataSource: PickerToolbarType>(pickerOnChange: @escaping (DataSource) -> Void)  -> some View where DataSource.AllCases == (Array<DataSource>) {
        return self.modifier(PickerToolbarViewModifier(pickerOnChange: pickerOnChange))
    }
    
    public func fontSystemRounded(_ style: Font.TextStyle) -> some View {
        return self.font(.system(style, design: .rounded))
    }
    
    @ViewBuilder
    public func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    public func didSelect<Container: Equatable>(containerSelected: Container?
                                                , successHandler: ((Container) -> Void)?) -> some View {
        return self.modifier(DidSelectViewModifier(containerSelected: containerSelected,
                                                   successHandler: successHandler))
    }
    
    public func viewDidLoad(handler: SimpleHandler? = nil) -> some View {
        return self.modifier(ViewDidLoadModifier(handler: handler))
    }
    
    public func asyncViewDidLoad(handler: AsyncHandler? = nil) -> some View {
        return self.modifier(AsyncViewDidLoadModifier(handler: handler))
    }
    
    @available(iOS 17, *)
    public func selectDismiss<Container: Equatable>(_ container: Container?,
                                                    successHandler: @escaping (Container) -> Void) -> some View {
        return self.modifier(SelectDismissViewModifier(containerSelected: container,
                                                       successHandler: successHandler))
    }
    
    public func asModal() -> some View {
        return self.modifier(ModalViewModifier())
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
                          andMessage: error as? String ?? error?.localizedDescription ?? "",
                          isPresented: isPresented,
                          isCancelRequired: isCancelRequired,
                          okHandler: okHandler)
    }
}
