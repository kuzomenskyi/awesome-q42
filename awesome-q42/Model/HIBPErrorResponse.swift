//
//  HIBPErrorResponse.swift
//  awesome-q42
//
//  Created by vladimir.kuzomenskyi on 15.09.2023.
//

import Foundation

struct HIBPErrorResponse: Codable {
    // MARK: Constant
    let statusCode: Int
    let message: String
}
