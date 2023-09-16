//
//  CheckerVM.swift
//  awesome-q42
//
//  Created by vladimir.kuzomenskyi on 16.09.2023.
//

import SwiftUI
import Combine

final class CheckerVM: ObservableObject {
    // MARK: Constant
    static let mock: CheckerVM = .init()
    
    let title: String = "Website Safety Checker"
    let placeholder: String = "Website address"
    let buttonTitle: String = "Check"
    
    // MARK: Private Constant
    
    // MARK: Variable
    @Published var websiteAddress: String = ""
    @Published private(set) var result: WebsiteCheckResult = .new
    
    var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: Private Variable
    
    // MARK: Init
    init() {
        
    }
    
    // MARK: Action
    
    // MARK: Private Action
    
    // MARK: Function
    func check() {
        
    }
    
    // MARK: Private Function
}

