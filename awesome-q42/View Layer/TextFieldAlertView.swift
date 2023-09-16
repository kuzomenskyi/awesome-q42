//
//  TextFieldAlertView.swift
//  awesome-q42
//
//  Created by vladimir.kuzomenskyi on 16.09.2023.
//

import SwiftUI
import Combine

struct TextFieldAlertView<Presenting>: View where Presenting: View {
    // MARK: Constant
    let presenting: Presenting
    let title: String
    let placeholder: String
    let acceptsNumericOnly: Bool
    let onCancel: PassthroughSubject<String, Never>
    let onOK: PassthroughSubject<String, Never>
    
    // MARK: Variable
    @Binding var isShowing: Bool
    @Binding var text: String

    var body: some View {
        GeometryReader { (deviceSize: GeometryProxy) in
            ZStack {
                self.presenting
                    .disabled(isShowing)
                VStack {
                    Text(self.title)
                    TextField(self.placeholder, text: self.$text)
                        .keyboardType(acceptsNumericOnly ? .numberPad : .default)
                    Spacer()
                        .frame(height: 15)
                    HStack(spacing: 20) {
                        Button(action: {
                            withAnimation {
                                self.isShowing.toggle()
                            }
                            let tempText = text
                            text = ""
                            onCancel.send(tempText)
                        }) {
                            Text("Cancel")
                        }
                        Button(action: {
                            withAnimation {
                                self.isShowing.toggle()
                            }
                            let tempText = text
                            text = ""
                            onOK.send(tempText)
                        }) {
                            Text("OK")
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .frame(
                    width: deviceSize.size.width*0.7,
                    height: deviceSize.size.height*0.7
                )
                .shadow(radius: 1)
                .opacity(self.isShowing ? 1 : 0)
            }
        }
    }
}

struct TextFieldAlertView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldAlertView(presenting: Text(""), title: "Title", placeholder: "Placeholder", acceptsNumericOnly: false, onCancel: .init(), onOK: .init(), isShowing: .constant(true), text: .constant(""))
    }
}

