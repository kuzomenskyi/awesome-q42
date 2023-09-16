//
//  WebsiteCheckResult.swift
//  awesome-q42
//
//  Created by vladimir.kuzomenskyi on 16.09.2023.
//

import SwiftUI

struct WebsiteCheckResult: Identifiable {
    // MARK: Constant
    static let new: WebsiteCheckResult = .init(message: "Welcome! Enter a website address below to quickly check its safety", image: Image("search"), result: "Click 'Check to get instant results and ensure a safe browsing experience")
    static let safe: WebsiteCheckResult = .init(message: "Great news! The website is safe!", image: Image("security"), result: "This web address did not appear in any of publicly known data leaks")
    static let unsafe: WebsiteCheckResult = .init(message: "Oh no... The website is unsafe!", image: Image("alert"), result: "This web leaked it`s user data 582 times. Use it at your own risk")
    static let error: WebsiteCheckResult = .init(message: "Something went wrong!", image: Image("error"), result: "We have encountered a problem. Please, contact the developer")
    static let wow: WebsiteCheckResult = .init(message: "Awesome!", image: Image("heart_splash"), alpha: 1, result: "Wow, what a great website! I really like the animations on the portfolio page")
    
    let id: UUID
    let message: String
    let image: Image
    let alpha: CGFloat
    
    // MARK: Variable
    var result: String
    
    // MARK: Init
    init(message: String, image: Image, alpha: CGFloat = 0.3, result: String) {
        self.id = .init()
        self.message = message
        self.image = image
        self.alpha = alpha
        self.result = result
    }
    
    // MARK: Function
    mutating func resultLeaked(times: Int?) {
        result = "This web leaked it`s user data \(times ?? 0) times. Use it at your own risk"
    }
}
