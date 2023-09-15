//
//  Emitter.swift
//  Just business
//
//  Created by vladimir.kuzomenskyi on 14.12.2020.
//  Copyright © 2020 vladimir.kuzomenskyi. All rights reserved.
//

import UIKit

class Emitter: IEmitter {
    // MARK: Constant
    
    // MARK: Private Constant
    
    // MARK: Variable
    var images: [UIImage?]
    
    lazy var layer: CAEmitterLayer = {
        let layer = CAEmitterLayer()
        layer.emitterShape = .line
        layer.emitterCells = emitterCells
        return layer
    }()
    
    // MARK: Private Variable
    
    private lazy var emitterCells: [CAEmitterCell] = {
        let cells = getEmitterCells(forImages: images)
        return cells
    }()
    
    // MARK: Init
    init(images: [UIImage?]) {
        assert(!images.isEmpty, "Emiters image is nil")
        self.images = images
    }
    
    // MARK: Action
    
    // MARK: Private Action
    
    // MARK: Function
    
    // MARK: Private Function
    private func getEmitterCells(forImages images: [UIImage?]) -> [CAEmitterCell] {
        var output = [CAEmitterCell]()
        
        for image in images {
            let cell = CAEmitterCell()
            if let image = image {
                cell.contents = image.cgImage
            }
            cell.birthRate = 3
            cell.lifetime = 8
            cell.velocity = 170
            cell.velocityRange = 40
            cell.emissionLongitude = .pi / 4
            cell.emissionRange = .pi / 6
            cell.scale = 0.8
            cell.scaleRange = 0.5
            cell.alphaRange = 0.3
            output.append(cell)
        }
        
        return output
    }
}
