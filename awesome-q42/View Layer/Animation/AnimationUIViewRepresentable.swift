//
//  AnimationUIViewRepresentable.swift
//  financial-plans
//
//  Created by vladimir.kuzomenskyi on 15.09.2022.
//

import UIKit
import SwiftUI

struct AnimatioUIViewRepresetable: UIViewRepresentable {
    // MARK: Constant
    
    // MARK: Private Constant
    
    // MARK: Variable
    @Binding var isCadleLightAnimating: Bool
    @Binding var isFlowingParticles: Bool
    
    // MARK: Private Variable
    
    // MARK: Init
    
    // MARK: Action
    
    // MARK: Private Action
    
    // MARK: Function
    func makeUIView(context: Context) -> some UIView {
        return AnimationUIView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        let uiView = uiView as! AnimationUIView
        if isFlowingParticles {
            uiView.startParticlesFlowingAnimation()
        } else {
            uiView.stopParticlesFlowingAnimation()
        }
    }
    
    // MARK: Private Function
}
