//
//  String.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 15/07/21.
//

import UIKit


extension String {
    
    func isLength(minimum: Int, maximum: Int) -> Bool {
        guard self.count >= minimum && self.count <= maximum else {
            return false
        }
        return true
    }
    
    enum ValidationParameter {
        case number
        case lowercaseLetter
        case uppercaseLetter
        case specialCharacter
        case whiteSpace
    }
    
    func contains(_ parameters: [ValidationParameter]) -> Bool {
        for parameter in parameters {
            switch parameter {
            case .lowercaseLetter:
                if self.rangeOfCharacter(from: .lowercaseLetters) == nil {
                    return false
                }
            case .uppercaseLetter:
                if self.rangeOfCharacter(from: .uppercaseLetters) == nil {
                    return false
                }
            case .number:
                if self.rangeOfCharacter(from: .decimalDigits) == nil {
                    return false
                }
            case .specialCharacter:
                if self.range(of: ".*[^A-Za-z0-9].*", options: .regularExpression) == nil {
                    return false
                }
            case .whiteSpace:
                if self.rangeOfCharacter(from: .whitespaces) == nil {
                    return false
                }
            }
        }
        return true
    }
    
    func isEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func generateQRCode() -> UIImage? {
        guard let data = self.data(using: .ascii) else { return nil }
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
}
