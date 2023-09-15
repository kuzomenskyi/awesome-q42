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
        var isCandleLightAnimating: Bool = false
        var isFlowingParticles: Bool = false
        var isPausedAnimations: Bool = false
    }
    
    static let mock: AnimatedBackgroundVM = .init(model: .init(isCandleLightAnimating: true, isFlowingParticles: true))
    
    @Published var model: Model
    
    var isCandleLightAnimating: Bool {
        get {
            model.isCandleLightAnimating
        }
        set {
            model.isCandleLightAnimating = newValue
        }
    }
    
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
    
    init(model: Model) {
        self.model = model
    }
}
