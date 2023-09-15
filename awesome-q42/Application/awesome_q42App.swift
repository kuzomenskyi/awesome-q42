//
//  awesome_q42App.swift
//  awesome-q42
//
//  Created by vladimir.kuzomenskyi on 15.09.2023.
//

import SwiftUI

@main
struct awesome_q42App: App {
    // MARK: Constant
    
    // MARK: Private Constant
    
    // MARK: Variable
    var body: some Scene {
        WindowGroup {
            ZStack {
                AnimatedBackgroundView(viewModel: animationViewModel)
            }
        }
    }
    
    // MARK: Private Variable
    @StateObject private var animationViewModel: AnimatedBackgroundVM = .init(model: .init(isCandleLightAnimating: false, isFlowingParticles: true))
    
    // MARK: Init
    
    // MARK: Action
    
    // MARK: Private Action
    
    // MARK: Function
    
    // MARK: Private Function
}
