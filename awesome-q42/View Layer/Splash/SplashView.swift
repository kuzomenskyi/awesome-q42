//
//  SplashView.swift
//  awesome-q42
//
//  Created by vladimir.kuzomenskyi on 15.09.2023.
//

import SwiftUI
import Combine

struct SplashView: View {
    // MARK: Constant
    
    // MARK: Private Constant
    
    // MARK: Variable
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            ZStack {
                viewModel.logo
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .scaleEffect(scale)
                    .onAppear() {
                        withAnimation(.easeIn(duration: 0.9).repeatCount(4)) {
                            scale = 1.5
                        }
                        
                        withAnimation(.easeIn(duration: 1).delay(1.5)) {
                            overlayOpacity = 1
                        }
                        
                        withAnimation(.easeIn(duration: 0.5).delay(3)) {
                            scale = 0
                        }
                        
                        withAnimation(.easeIn(duration: 1).delay(3)) {
                            opacity = 0
                        }
                    }
                    .position(x: size.width / 2, y: size.height * 0.45)
                
                Rectangle()
                    .foregroundColor(Color(hex: "84BA24"))
                    .ignoresSafeArea()
                    .opacity(overlayOpacity)
                    .frame(width: size.width, height: size.height)
                    .position(x: size.width / 2, y: size.height / 2)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: .init(block: {
                            viewModel.onWillClose.send()
                        }))

                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.6, execute: .init(block: {
                            viewModel.onDidClose.send()
                        }))
                    }
            }
        }
        .opacity(opacity)
    }
    
    // MARK: Private Variable
    @StateObject private var viewModel: SplashVM
    @State private var scale: CGFloat = 1
    @State private var isAnimating: Bool = false
    @State private var overlayOpacity: CGFloat = 0
    @State private var opacity: CGFloat = 1
    
    // MARK: Init
    init(viewModel: SplashVM) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: Action
    
    // MARK: Private Action
    
    // MARK: Function
    
    // MARK: Private Function
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        let view = SplashView(viewModel: .mock)
        
        return Group {
            view
                .previewDevice(PreviewDevice(rawValue: "iPhone 13 mini"))
                .previewDisplayName("iPhone 13 mini")
            view
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}

