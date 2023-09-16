//
//  ScrollingText.swift
//  awesome-q42
//
//  Created by vladimir.kuzomenskyi on 16.09.2023.
//

import SwiftUI

struct ScrollingText: View {
    // MARK: Private Constant
    private let animation = Animation.linear(duration: 10).repeatForever(autoreverses: false)
    
    // MARK: Variable
    @State var text = ""
    
    var body : some View {
        let stringWidth = text.widthOfString(usingFont: UIFont.systemFont(ofSize: 15))
        return ZStack {
            GeometryReader { geometry in
                Text(self.text).lineLimit(1)
                    .font(.subheadline)
                    .offset(x: self.isAnimating ? -stringWidth * 2 : 0)
                    .animation(self.animation, value: self.isAnimating)
                    .onAppear() {
                        if geometry.size.width < stringWidth {
                            self.isAnimating = true
                        }
                    }
                    .fixedSize(horizontal: true, vertical: false)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                
                Text(self.text).lineLimit(1)
                    .font(.subheadline)
                    .offset(x: self.isAnimating ? 0 : stringWidth * 2)
                    .animation(self.animation, value: self.isAnimating)
                    .fixedSize(horizontal: true, vertical: false)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            }
        }
    }
    
    // MARK: Private Variable
    @State private var isAnimating = false
}
