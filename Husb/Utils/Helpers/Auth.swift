//
//  Auth.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 15/07/21.
//

import Foundation
import CryptoSwift

fileprivate extension String {
    
}

class Auth {
    
    static let password: String = "BNOIBvw0901-ncw-=0-9"
    static let salt: String = "aezAkm1"
    static let iv = AES.randomIV(AES.blockSize)
    static let iterations: Int = 4096
    static let keyLength: Int = 32
    
    static func encrypt(_ string: String) -> String? {
        let password: [UInt8] = Array(Auth.password.utf8)
        let salt: [UInt8] = Array(Auth.salt.utf8)

        /* Generate a key from a `password`. Optional if you already have a key */
        guard let key = try? PKCS5.PBKDF2(
            password: password,
            salt: salt,
            iterations: Auth.iterations,
            keyLength: Auth.keyLength, /* AES-256 */
            variant: .sha256
        ).calculate() else { return nil }

        /* AES cryptor instance */
        guard let aes = try? AES(key: key, blockMode: CBC(iv: Auth.iv), padding: .pkcs7) else { return nil }
        
        /* Encrypt Data */
        guard let inputData = string.data(using: .utf8) else { return nil }
        guard let encryptedBytes = try? aes.encrypt(inputData.bytes) else { return nil }
        return String(data: Data(encryptedBytes), encoding: .utf8)
    }
    

    
    static func decrypt(_ data: String) -> String? {
        let password: [UInt8] = Array(Auth.password.utf8)
        let salt: [UInt8] = Array(Auth.salt.utf8)

        /* Generate a key from a `password`. Optional if you already have a key */
        guard let key = try? PKCS5.PBKDF2(
            password: password,
            salt: salt,
            iterations: Auth.iterations,
            keyLength: Auth.keyLength, /* AES-256 */
            variant: .sha256
        ).calculate() else { return nil }

        /* AES cryptor instance */
        guard let aes = try? AES(key: key, blockMode: CBC(iv: Auth.iv), padding: .pkcs7) else { return nil }
        
        guard let decryptedBytes = try? aes.decrypt(data.bytes) else { return nil }
        
        let decryptedData = Data(decryptedBytes)
        let result = String(data: decryptedData, encoding: .utf8)
        return result
    }
    
}
