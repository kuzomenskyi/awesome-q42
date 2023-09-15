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
    func testSearchingLeaksByPhoneNumber() {
        let expectation = expectation(description: "testSearchNumber")
        Task {
            do {
                let _ = try await networkManager.searchLeaks(byPhoneNumber: "asdasd")
                XCTFail("Not failed with wrong number")
                expectation.fulfill()
            } catch {
                do {
                    // This number is not leaked
                    let _ = try await networkManager.searchLeaks(byPhoneNumber: "380669582930222")
                    expectation.fulfill()
                } catch {
                    guard CustomError.numberNotFound.isEqualTo(error) else {
                        XCTFail("Failed with error: \(error)")
                        expectation.fulfill()
                        return
                    }
                    
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
