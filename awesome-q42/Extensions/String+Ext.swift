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
    
    func numbersOnly() -> String {
        return String(self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }
}

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

extension String {
   func widthOfString(usingFont font: UIFont) -> CGFloat {
       let fontAttributes = [NSAttributedString.Key.font: font]
       let size = self.size(withAttributes: fontAttributes)
       return size.width
   }

   func heightOfString(usingFont font: UIFont) -> CGFloat {
       let fontAttributes = [NSAttributedString.Key.font: font]
       let size = self.size(withAttributes: fontAttributes)
       return size.height
   }

   func sizeOfString(usingFont font: UIFont) -> CGSize {
       let fontAttributes = [NSAttributedString.Key.font: font]
       return self.size(withAttributes: fontAttributes)
   }
}
