//
//  NetworkManagerTests.swift
//  awesome-q42Tests
//
//  Created by vladimir.kuzomenskyi on 15.09.2023.
//

import XCTest
@testable import awesome_q42
// TODO: Remove if not needed
//import JavaScriptCore

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
        let manager: NetworkManager = .init()
        
        let expectation = XCTestExpectation(description: "testGetSpamDBInfo")
        
        Task {
            do {
                let _ = try await manager.getSpamDBInfo()
                expectation.fulfill()
            } catch {
                XCTFail("Failed testGetSpamDBInfo with error: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testSearchNumber() {
        let manager = NetworkManager()
        
        let expectation = expectation(description: "testSearchNumber")
        Task {
            do {
                let _ = try await manager.searchNumber("asdasd")
                XCTFail("Not failed with wrong number")
                expectation.fulfill()
            } catch {
                do {
                    let _ = try await manager.searchNumber("380669582930")
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
        // TODO: Configure
    }
    
    func testSearchingDataLeaksByPassword() {
        let manager = networkManager
        
        let expectation = expectation(description: "testSearchingDataLEaksByPassword")
        
        Task {
            do {
                let leaks = try await manager.searchLeaks(byPassword: "qwerty")
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
        // TODO: Configure
    }
    
    func testGettingIconForWebsite() {
        // TODO: Configure
    }
    
    func testGettingDomainName() {
        // TODO: Configure
    }
    
    // MARK: Private Function
}
