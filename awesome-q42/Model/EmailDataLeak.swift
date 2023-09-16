//
//  EmailDataLeak.swift
//  awesome-q42
//
//  Created by vladimir.kuzomenskyi on 15.09.2023.
//

import Foundation

struct EmailDataLeak: Codable {
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case title = "Title"
        case domain = "Domain"
        case breachDate = "BreachDate"
        case addedDate = "AddedDate"
        case modifiedDate = "ModifiedDate"
        case pwnCount = "PwnCount"
        case description = "Description"
        case logoPath = "LogoPath"
        case dataClasses = "DataClasses"
        case isVerified = "IsVerified"
        case isFabricated = "IsFabricated"
        case isSensitive = "IsSensitive"
        case isRetired = "IsRetired"
        case isSpamList = "IsSpamList"
        case isMalware = "IsMalware"
    }
    
    // MARK: Constant
    let name, title, domain, breachDate: String
    let addedDate, modifiedDate: String
    let pwnCount: Int
    let description: String
    let logoPath: String
    let dataClasses: [String]
    let isVerified, isFabricated, isSensitive, isRetired: Bool
    let isSpamList, isMalware: Bool
}
