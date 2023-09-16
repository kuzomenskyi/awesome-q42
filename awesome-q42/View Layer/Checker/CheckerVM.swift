//
//  CheckerVM.swift
//  awesome-q42
//
//  Created by vladimir.kuzomenskyi on 16.09.2023.
//

import SwiftUI
import Combine

final class CheckerVM: ObservableObject {
    // MARK: Constant
    static let mock: CheckerVM = .init()
    
    let title: String = "Website Safety Checker"
    let placeholder: String = "Website address"
    let buttonTitle: String = "Check"
    
    // MARK: Private Constant
    private let networkManager: NetworkManager = .init()
    
    // MARK: Variable
    @Published var isLoaderDisplayed: Bool = false
    @Published var websiteAddress: String = ""
    @Published private(set) var result: WebsiteCheckResult = .new
    @Published var isErrorDisplayed: Bool = false
    var error: CustomError = .invalidWebsiteAddress
    
    var cancellables: Set<AnyCancellable> = .init()
    private(set) var alertAction: (() -> Void)?
    
    // MARK: Private Variable
    
    // MARK: Init
    init() {
        
    }
    
    // MARK: Action
    
    // MARK: Private Action
    
    // MARK: Function
    func check() {
        guard isWebsiteAddressValid(websiteAddress) else {
            isErrorDisplayed = true
            return
        }
        
        isLoaderDisplayed = true
        
        Task {
            do {
                var input: String {
                    let string = websiteAddress.contains("https://") ? websiteAddress : "https://" + websiteAddress
                    return string
                }
                
                if let result = try await self.networkManager.checkWebsite(input) {
                    let _ = await MainActor.run {
                        self.isLoaderDisplayed = false
                        print("🔦 The website is not safe")
                        self.result = .unsafe
                        self.result.resultLeaked(times: result.pwnCount)
                    }
                } else {
                    let _ = await MainActor.run {
                        self.isLoaderDisplayed = false
                        print("🔦 The website is safe")
                        self.result = .safe
                    }
                }
            } catch {
                let _ = await MainActor.run {
                    self.isLoaderDisplayed = false
                    print("🚨 Error getting info about the website: \(error)")
                    self.result = .error
                    alertAction = { [weak self] in
                        self?.isErrorDisplayed = false
                    }
                }
            }
        }
    }
    
    // MARK: Private Function
    private func isWebsiteAddressValid(_ websiteAddress: String) -> Bool {
        return websiteAddress.count > 5 && websiteAddress.contains(".")
    }
}

