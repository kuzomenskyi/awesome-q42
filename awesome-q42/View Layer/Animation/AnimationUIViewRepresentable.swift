//
//  AnimationUIViewRepresentable.swift
//  financial-plans
//
//  Created by vladimir.kuzomenskyi on 15.09.2022.
//

import UIKit
import SwiftUI

struct AnimatioUIViewRepresetable: UIViewRepresentable {
    // MARK: Variable
    @Binding var isFlowingParticles: Bool
    
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
}
