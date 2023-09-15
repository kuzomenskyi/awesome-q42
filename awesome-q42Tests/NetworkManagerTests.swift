//
//  NetworkManagerTests.swift
//  awesome-q42Tests
//
//  Created by vladimir.kuzomenskyi on 15.09.2023.
//

import XCTest
@testable import awesome_q42

final class NetworkManagerTests: XCTestCase {
    // MARK: Constant
    
    // MARK: Private Constant
    private let networkManager: NetworkManager = .init()
    
    // MARK: Variable
    
    // MARK: Private Variable
    
    // MARK: Init
    
    // MARK: Action
    
    // MARK: Private Action
    
    // MARK: Function
    func testGetSpamDBInfo() {
        let expectation = XCTestExpectation(description: "testGetSpamDBInfo")
        
        Task {
            do {
                let _ = try await networkManager.getSpamDBInfo()
                expectation.fulfill()
            } catch {
                XCTFail("Failed testGetSpamDBInfo with error: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testSearchNumber() {
        let expectation = expectation(description: "testSearchNumber")
        Task {
            do {
                let _ = try await networkManager.searchNumber("asdasd")
                XCTFail("Not failed with wrong number")
                expectation.fulfill()
            } catch {
                do {
                    let _ = try await networkManager.searchNumber("380669582930")
                    expectation.fulfill()
                } catch {
                    XCTFail("Failed with error: \(error)")
                    expectation.fulfill()
                }
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testSearchingDataLeaksByEmail() {
        let expectation = expectation(description: "testSearchingDataLeaksByEmail")
        
        Task {
            do {
                // Leaked email
                let leaks = try await networkManager.searchLeaks(byEmail: "qwerty123@gmail.com")
                print("leaks:", leaks)
                
                XCTAssertTrue(leaks.count > 0)
                expectation.fulfill()
            } catch {
                XCTFail("Failed with error: \(error)")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testSearchingDataLeaksByPassword() {
        let expectation = expectation(description: "testSearchingDataLEaksByPassword")
        
        Task {
            do {
                // Leaked password
                let leaks = try await networkManager.searchLeaks(byPassword: "qwerty")
                print("leaks:", leaks)
                
                XCTAssertTrue(leaks > 0)
                expectation.fulfill()
            } catch {
                XCTFail("Failed with error: \(error)")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
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
    
    func testGettingIconForWebsite() {
        let expectation = expectation(description: "testGettingIconForWebsite")
        
        Task {
            do {
                // Leaked website
                let result = try await networkManager.getIcon(forWebsite: "https://www.google.com")
                print("result:", result as Any)
                
                XCTAssertTrue(result != nil)
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
    
    // MARK: Private Function
}
