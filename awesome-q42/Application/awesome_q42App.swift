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
                switch viewModel.route {
                case .splash:
                    SplashView(viewModel: splashVM)
                case .home:
                    Text("Home screen")
                }
            }
            .onAppear {
                viewModel.configure(splashVM: splashVM, animatedBackgroundVM: animationViewModel)
            }
        }
    }
    
    // MARK: Private Variable
    @StateObject private var viewModel: AppVM = .mock
    @StateObject private var animationViewModel: AnimatedBackgroundVM = .init(model: .init(isFlowingParticles: false))
    @StateObject private var splashVM: SplashVM = .mock
    
    // MARK: Init
    
    // MARK: Action
    
    // MARK: Private Action
    
    // MARK: Function
    
    // MARK: Private Function
}
