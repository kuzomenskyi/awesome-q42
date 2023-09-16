//
//  AnimatedBackgroundView.swift
//  financial-plans
//
//  Created by vladimir.kuzomenskyi on 15.09.2022.
//

import SwiftUI

struct AnimatedBackgroundView: View {
    // MARK: Variable
    var body: some View {
        AnimatioUIViewRepresetable(isFlowingParticles: $viewModel.model.isFlowingParticles)
            .onChange(of: scenePhase, perform: { newPhase in
                let shouldAnimate = newPhase == .active
                
                if viewModel.model.isPausedAnimations {
                    viewModel.model.isFlowingParticles = shouldAnimate
                }
                viewModel.model.isPausedAnimations = !shouldAnimate
            })
    }
    
    @ObservedObject var viewModel: AnimatedBackgroundVM
    
    // MARK: Private Variable
    @Environment(\.scenePhase) private var scenePhase
}

struct AnimatedBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedBackgroundView(viewModel: .mock)
            .previewInterfaceOrientation(.portrait)
    }
}
