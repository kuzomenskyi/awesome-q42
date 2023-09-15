//
//  CustomError.swift
//  awesome-q42
//
//  Created by vladimir.kuzomenskyi on 15.09.2023.
//

import Foundation

class CustomError: NSError {
    // MARK: Constant
    static let numberNotFound: CustomError = .init("Number not found".localizedString, code: 1)
    static let invalidWebsiteAddress: CustomError = .init("Please, make sure the website address is valid".localizedString, code: 2)
    
    // MARK: Private Constant
    
    // MARK: Variable
    var title: String?
    var errorDescription: String
    var errorCode: Int
    
    override var code: Int {
        return errorCode
    }
    
    override var description: String {
        return errorDescription
    }
    
    override var localizedDescription: String {
        return errorDescription
    }
    
    // MARK: Private Variable
    
    // MARK: Init
    init(_ description: String, code: Int) {
        self.title = "Error"
        self.errorDescription = description
        self.errorCode = code
        super.init(domain: "", code: code, userInfo: nil)
    }
    
    init(_ description: String) {
        let defaultCode = -1
        self.errorDescription = ""
        self.errorCode = -1
        super.init(domain: "", code: defaultCode, userInfo: nil)
        self.title = "Error"
        self.errorDescription = description
        self.errorCode = defaultCode
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Action
    
    // MARK: Private Action
    
    // MARK: Function
    func isEqualTo(_ error: Error) -> Bool {
        return (error as NSError).code == code
    }
    
    // MARK: Private Function
}
