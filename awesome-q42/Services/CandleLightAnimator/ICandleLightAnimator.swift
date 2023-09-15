//
//  ICandleLightAnimator.swift
//  Just business
//
//  Created by vladimir.kuzomenskyi on 15.12.2020.
//  Copyright © 2020 vladimir.kuzomenskyi. All rights reserved.
//

import UIKit

protocol ICandleLightAnimator: AnyObject {
    var viewToAnimateOn: UIView { get set }
    var candleLightLayer: CAGradientLayer { get }
    var isAnimating: Bool { get }
    
    func startAnimating()
    func stopAnimating()
}
