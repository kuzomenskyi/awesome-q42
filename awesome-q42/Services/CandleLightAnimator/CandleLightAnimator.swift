//
//  CandleLightAnimator.swift
//  Just business
//
//  Created by vladimir.kuzomenskyi on 15.12.2020.
//  Copyright © 2020 vladimir.kuzomenskyi. All rights reserved.
//

import UIKit

class CandleLightAnimator: NSObject, ICandleLightAnimator {
    // MARK: Constant
    
    // MARK: Private Constant
    private let shortinterval: CFTimeInterval = 0.35
    private let longInterval: CFTimeInterval = 0.75
    private let shortIntervalShift: CGFloat = UIScreen.main.bounds.height * 0.1
    private let longIntervalShift: CGFloat = UIScreen.main.bounds.height * 0.3
    private let candleLightAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
    
    // MARK: Variable
    var viewToAnimateOn: UIView
    
    private(set) var isAnimating = false
    
    lazy var candleLightLayer: CAGradientLayer = {
        let candleLightLayer = CAGradientLayer()
        candleLightLayer.type = .radial
        candleLightLayer.colors = [ UIColor.clear,
                                    .black
            ].map { $0.cgColor }
        candleLightLayer.locations = [0.6, 1]
        candleLightLayer.opacity = 0.23
        candleLightLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        candleLightLayer.endPoint = CGPoint(x: 1, y: 1)
        return candleLightLayer
    }()
    
    // MARK: Private Variable
    private var timer = Timer()
    private var animationCounter = 0
    private var animationCompletion: (() -> Void)?
    private var shouldPauseAnimation = false
    
    private var isNewAnimationCycleRequired = false {
        didSet {
            if isNewAnimationCycleRequired && !isAnimating {
                performAnimationCycle()
            }
        }
    }
    
    private lazy var screenEventsObserver: IScreenEventsObserver = ScreenEventsObserver()
    
    // MARK: Init
    init(viewToAnimateOn view: UIView) {
        self.viewToAnimateOn = view
        super.init()
        
        DispatchQueue.main.async { [weak self] in
            self?.setCandleLightLayer()
        }
        
        screenEventsObserver.observerForDidEnterBackground { [weak self] in
            guard let self = self else { return }
            
            if self.isAnimating {
                self.shouldPauseAnimation = true
            }
            self.stopAnimating()
        }
        
        screenEventsObserver.observeForWillEnterForeground { [weak self] in
            guard let self = self, self.shouldPauseAnimation else { return }
            self.startAnimating()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Action
    
    // MARK: Private Action
    
    // MARK: Function
    func startAnimating() {
        if !(viewToAnimateOn.layer.sublayers?.contains(candleLightLayer) ?? false) {
            DispatchQueue.main.async { [weak self] in
                self?.setCandleLightLayer()
            }
        }
        
        performAnimationCycle()
    }
    
    func stopAnimating() {
        animationCompletion = nil
        candleLightLayer.removeFromSuperlayer()
        candleLightLayer.delegate = nil
        isAnimating = false
    }
    
    // MARK: Private Function
    private func setCandleLightLayer() {
        guard !(candleLightLayer.sublayers?.contains(candleLightLayer) ?? false) else { return }
        viewToAnimateOn.layer.insertSublayer(candleLightLayer, at: 0)
        
        let width = viewToAnimateOn.bounds.width * 1.4
        let height = viewToAnimateOn.bounds.height * 1.4
        let originX = viewToAnimateOn.center.x - width / 2
        let originY = viewToAnimateOn.center.y - height / 2
        candleLightLayer.frame = CGRect(x: originX, y: originY, width: width, height: height)
    }
    
    private func performAnimation(interval: TimeInterval, repetitions: Float, completion: (() -> Void)? = nil) {
        
        func handle() {
            candleLightAnimation.delegate = self
            candleLightAnimation.values = [1, 1.1, 1]
            candleLightAnimation.duration = interval
            candleLightAnimation.isRemovedOnCompletion = false
            candleLightAnimation.repeatCount = repetitions
            candleLightAnimation.fillMode = .forwards
            animationCompletion = completion
            candleLightLayer.add(candleLightAnimation, forKey: nil)
        }
        
        DispatchQueue.main.async {
            handle()
        }
    }
    
    private func performAnimationCycle() {
        guard !isAnimating else { return }
        isAnimating = true
        
        performAnimation(interval: shortinterval, repetitions: 8) { [weak self] in
            guard let self = self else { return }
            self.performAnimation(interval: self.longInterval, repetitions: 2) {
                self.performAnimation(interval: self.shortinterval, repetitions: 5) {
                    self.performAnimation(interval: self.longInterval, repetitions: 1) {
                        self.performAnimation(interval: self.shortinterval, repetitions: 7) {
                            self.performAnimation(interval: self.longInterval, repetitions: 2, completion: {
                                self.isAnimating = false
                                self.isNewAnimationCycleRequired = true
                            })
                        }
                    }
                }
            }
        }
    }
    
    // MARK: Deinit
    deinit {
        stopAnimating()
    }
}

// MARK: - CAAnimationDelegate
extension CandleLightAnimator: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            animationCompletion?()
        }
    }
}
