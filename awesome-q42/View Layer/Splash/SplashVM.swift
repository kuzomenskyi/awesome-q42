//
//  SplashVM.swift
//  awesome-q42
//
//  Created by vladimir.kuzomenskyi on 15.09.2023.
//

import SwiftUI
import Combine

final class SplashVM: ObservableObject {
    // MARK: Constant
    static let mock: SplashVM = .init()
    
    let logo = Image("heart_splash")
    let onDidClose: PassthroughSubject<Void, Never> = .init()
    let onWillClose: PassthroughSubject<Void, Never> = .init()
    
    // MARK: Private Constant
    
    // MARK: Variable
    var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: Private Variable
    
    // MARK: Init
    init() {
        
    }
    
    // MARK: Action
    
    // MARK: Private Action
    
    // MARK: Function
    
    // MARK: Private Function
}
