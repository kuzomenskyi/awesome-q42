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
                // TODO: UNcomment
//                switch viewModel.route {
//                case .splash:
//                    SplashView(viewModel: splashVM)
//                case .home:
                    HomeView(viewModel: homeVM)
//                }
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
    @StateObject private var homeVM: HomeVM = .mock
    
    // MARK: Init
    
    // MARK: Action
    
    // MARK: Private Action
    
    // MARK: Function
    
    // MARK: Private Function
}
