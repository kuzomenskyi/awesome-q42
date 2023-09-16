//
//  LoadingView.swift
//  awesome-q42
//
//  Created by vladimir.kuzomenskyi on 16.09.2023.
//

import SwiftUI

struct LoadingView<Content: View>: View {
    @Binding var isShowing: Bool
    var content: Content

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                self.content
                    .disabled(self.isShowing)
                
                if self.isShowing {
                    BlurView(style: .prominent)
                        .ignoresSafeArea()
                }

                VStack {
                    Text("Loading...")
                        .foregroundColor(.white)
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                .background(Color.black.opacity(0.1))
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)
            }
        }
    }
    
    init(isShowing: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._isShowing = isShowing
        self.content = content()
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isShowing: .constant(true), content: {
            Rectangle()
                .fill(Color.gray)
                .ignoresSafeArea()
        })
        .background(Color.black)
    }
}
