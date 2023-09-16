//
//  View+Ext.swift
//  awesome-q42
//
//  Created by vladimir.kuzomenskyi on 16.09.2023.
//

import SwiftUI
import Combine

extension View {
    // MARK: Function
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                self
                placeholder().opacity(shouldShow ? 1 : 0)
            }
        }
    
    func textFieldAlert(isShowing: Binding<Bool>,
                        text: Binding<String>,
                        title: String,
                        placeholder: String,
                        acceptsNumericOnly: Bool,
                        onCancel: PassthroughSubject<String, Never>,
                        onOK: PassthroughSubject<String, Never>) -> some View {
        TextFieldAlertView(presenting: self,
                           title: title,
                           placeholder: placeholder,
                           acceptsNumericOnly: acceptsNumericOnly,
                           onCancel: onCancel,
                           onOK: onOK,
                           isShowing: isShowing,
                           text: text
        )
    }
}
