//
//  AppVM.swift
//  awesome-q42
//
//  Created by vladimir.kuzomenskyi on 16.09.2023.
//

import SwiftUI
import Combine

final class AppVM: ObservableObject {
    enum Route {
        case splash, home
    }
    
    // MARK: Constant
    static let mock: AppVM = .init()
    
    // MARK: Variable
    @Published var route: Route = .splash
    var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: Init
    init() {
        
    }
    
    // MARK: Function
    func configure(splashVM: SplashVM, animatedBackgroundVM: AnimatedBackgroundVM) {
        splashVM.onWillClose.sink {
            animatedBackgroundVM.isFlowingParticles = true
        }
        .store(in: &splashVM.cancellables)
        
        splashVM.onDidClose.sink { [weak self] in
            self?.route = .home
        }
        .store(in: &splashVM.cancellables)
    }
}

