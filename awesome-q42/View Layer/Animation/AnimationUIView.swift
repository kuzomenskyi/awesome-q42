//
//  AnimationUIView.swift
//  financial-plans
//
//  Created by vladimir.kuzomenskyi on 15.09.2022.
//

import UIKit
import SwiftUI

class AnimationUIView: UIView {
    // MARK: Variable
    lazy var emitter: IEmitter = Emitter(images: [Images.heart])
    
    // MARK: Function
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let emitterLayer = emitter.layer
        emitterLayer.position = CGPoint(x: 0, y: frame.height * 1.2)
        emitterLayer.emitterSize = CGSize(width: frame.width, height: 2)
    }
    
    func startParticlesFlowingAnimation() {
        let isEmitterLayerAdded = layer.sublayers?.contains(emitter.layer) ?? false
        
        guard !isEmitterLayerAdded else { return }
        let emitterLayer = emitter.layer
        emitterLayer.position = CGPoint(x: 0, y: frame.height)
        emitterLayer.emitterSize = CGSize(width: frame.width, height: 2)
        layer.insertSublayer(emitterLayer, at: 0)
    }
    
    func stopParticlesFlowingAnimation() {
        emitter.layer.removeFromSuperlayer()
    }
}
