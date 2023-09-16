//
//  WebsiteCheckResult.swift
//  awesome-q42
//
//  Created by vladimir.kuzomenskyi on 16.09.2023.
//

import SwiftUI

struct WebsiteCheckResult: Identifiable {
    static let new: WebsiteCheckResult = .init(message: "Welcome! Enter a website address below to quickly check its safety", result: "Click 'Check to get instant results and ensure a safe browsing experience", image: Image("search"))
    static let safe: WebsiteCheckResult = .init(message: "Great news! The website is safe!", result: "This web address did not appear in any of publicly known data leaks", image: Image("security"))
    static let unsafe: WebsiteCheckResult = .init(message: "Oh no... The website is unsafe!", result: "This web leaked it`s user data 582 times. Use it at your own risk", image: Image("alert"))
    static let error: WebsiteCheckResult = .init(message: "Something went wrong!", result: "We have encountered a problem. Please, contact the developer", image: Image("error"))
    static let wow: WebsiteCheckResult = .init(message: "Awesome!", result: "Wow, what a great website! I really like the animations on the portfolio page", image: Image("heart_splash"), alpha: 1)
    
    let id: UUID
    let message: String
    var result: String
    let image: Image
    let alpha: CGFloat
    
    init(message: String, result: String, image: Image, alpha: CGFloat = 0.3) {
        self.id = .init()
        self.message = message
        self.result = result
        self.image = image
        self.alpha = alpha
    }
    
    mutating func resultLeaked(times: Int?) {
        result = "This web leaked it`s user data \(times ?? 0) times. Use it at your own risk"
    }
}
