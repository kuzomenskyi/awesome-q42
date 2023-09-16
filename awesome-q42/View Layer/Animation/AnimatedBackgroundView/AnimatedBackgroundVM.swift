//
//  AnimatedBackgroundVM.swift
//  financial_plans
//
//  Created by vladimir.kuzomenskyi on 11.05.2023.
//

import SwiftUI
import Combine

final class AnimatedBackgroundVM: ObservableObject {
    struct Model {
        var isFlowingParticles: Bool = false
        var isPausedAnimations: Bool = false
    }
    
    // MARK: Constant
    static let mock: AnimatedBackgroundVM = .init(model: .init(isFlowingParticles: true))
    
    // MARK: Variable
    @Published var model: Model
    
    var isFlowingParticles: Bool {
        get {
            model.isFlowingParticles
        }
        set {
            model.isFlowingParticles = newValue
        }
    }
    
    var isPausedAnimations: Bool {
        get {
            model.isPausedAnimations
        }
        set {
            model.isPausedAnimations = newValue
        }
    }
    
    // MARK: Init
    init(model: Model) {
        self.model = model
    }
}
