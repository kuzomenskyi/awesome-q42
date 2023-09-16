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
    
    let id: UUID = .init()
    let message: String
    let result: String
    let image: Image
}
