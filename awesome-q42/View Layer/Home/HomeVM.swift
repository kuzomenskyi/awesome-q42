//
//  HomeVM.swift
//  awesome-q42
//
//  Created by vladimir.kuzomenskyi on 16.09.2023.
//

import SwiftUI
import Combine

final class HomeVM: ObservableObject {
    // MARK: Constant
    static let mock: HomeVM = .init()
    
    // MARK: Variable
    var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: Init
    init() {
        
    }
}

