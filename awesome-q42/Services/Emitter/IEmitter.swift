//
//  IEmitter.swift
//  Just business
//
//  Created by vladimir.kuzomenskyi on 14.12.2020.
//  Copyright © 2020 vladimir.kuzomenskyi. All rights reserved.
//

import UIKit

protocol IEmitter: AnyObject {
    var images: [UIImage?] { get set }
    var layer: CAEmitterLayer { get }
}
