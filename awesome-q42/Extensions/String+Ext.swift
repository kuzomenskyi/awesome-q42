//
//  String+Ext.swift
//  awesome-q42
//
//  Created by vladimir.kuzomenskyi on 15.09.2023.
//

import UIKit
import CommonCrypto

// TODO: Remove if not needed
extension String {
    // MARK: Variable
    var localizedString: String {
        return NSLocalizedString(self, comment: "")
    }
    
//    var byWords: [String] {
//        return components(separatedBy: " ")
//    }
//
    // MARK: Function
//    func stringBefore(_ delimiter: Character) -> String {
//        if let index = firstIndex(of: delimiter) {
//            return String(prefix(upTo: index))
//        } else {
//            return ""
//        }
//    }
//
//    func stringAfter(_ delimiter: Character) -> String {
//        if let index = firstIndex(of: delimiter) {
//            return String(suffix(from: index).dropFirst())
//        } else {
//            return ""
//        }
//    }
//
    func numbersOnly() -> String {
        return String(self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }
//
//    func toImage() -> UIImage? {
//        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
//            return UIImage(data: data)!
//        }
//        return nil
//    }
//
//    func lastWords(numberOfWords: Int) -> String {
//        byWords.suffix(numberOfWords).joined(separator: " ")
//    }
//
//    func word(at index: Int) -> String {
//        guard byWords.indices.contains(index) else {
//            return ""
//        }
//        return String(byWords[index])
//    }
}
//
//extension StringProtocol {
//    var data: Data { .init(utf8) }
//    var bytes: [UInt8] { .init(utf8) }
//}

extension String {
    func sha1() -> String {
        let data = Data(self.utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA1($0.baseAddress, CC_LONG(data.count), &digest)
        }
        let hexBytes = digest.map { String(format: "%02hhx", $0) }
        return hexBytes.joined()
    }
}
