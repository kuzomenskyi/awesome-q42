//
//  TextFieldModifier.swift
//  awesome-q42
//
//  Created by vladimir.kuzomenskyi on 16.09.2023.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    // MARK: Variable
    var whenToShowPlaceholder: Bool
    var placeholderText: String
    
    // MARK: Function
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            let size = geometry.size
            
            content
                .padding([.horizontal], 10)
                .padding(10)
                .background(Color.init(hex: "F9F9F9"))
                .cornerRadius(10)
                .font(.system(size: 14, weight: .regular))
                .placeholder(when: whenToShowPlaceholder, placeholder: {
                    Text(placeholderText)
                        .foregroundColor(.init(hex: "CCCCCC"))
                        .font(.system(size: 14, weight: .regular))
                        .italic()
                        .padding([.horizontal], 15)
                        .allowsHitTesting(false)
                })
                .padding([.horizontal], 15)
                .frame(height: size.height)
        }
    }
}

