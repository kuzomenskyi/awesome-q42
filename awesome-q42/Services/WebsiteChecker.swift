//
//  WebsiteChecker.swift
//  awesome-q42
//
//  Created by vladimir.kuzomenskyi on 16.09.2023.
//

import Foundation

protocol WebsiteChecker {
    func checkWebsite(_ address: String) async throws -> WebsiteCheckResponse?
    func getDomainName(from url: String) -> String?
}
