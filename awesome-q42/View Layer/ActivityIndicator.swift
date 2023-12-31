//
//  ActivityIndicator.swift
//  awesome-q42
//
//  Created by vladimir.kuzomenskyi on 16.09.2023.
//

import UIKit
import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    // MARK: Constant
    let style: UIActivityIndicatorView.Style
    
    // MARK: Variable
    @Binding var isAnimating: Bool
    
    // MARK: Function
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
        uiView.color = .white
    }
}

