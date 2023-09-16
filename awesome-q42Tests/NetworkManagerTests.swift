//
//  NetworkManagerTests.swift
//  awesome-q42Tests
//
//  Created by vladimir.kuzomenskyi on 15.09.2023.
//

import XCTest
@testable import awesome_q42

final class NetworkManagerTests: XCTestCase {
    // MARK: Private Constant
    private let networkManager: WebsiteChecker = NetworkManager()
    
    // MARK: Function
    func testCheckingWebsite() {
        let expectation = expectation(description: "testCheckingWebsite")
        
        Task {
            do {
                // Leaked website
                let result = try await networkManager.checkWebsite("https://www.jefit.com")
                print("result:", result as Any)
                
                XCTAssertTrue((result?.pwnCount ?? 0) > 0)
                expectation.fulfill()
            } catch {
                XCTFail("Failed with error: \(error)")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testGettingDomainName() {
        let result = networkManager.getDomainName(from: "https://www.google.com")
        print("result:", result as Any)
        
        XCTAssertTrue(result == "google")
    }
}
