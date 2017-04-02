//
//  String+SymmetricCryptor.swift
//  ARKCrypto
//
//  Created by Lee on 2017/4/2.
//  Copyright © 2017年 arKen. All rights reserved.
//

import Foundation

// MARK: Convenient
extension String {
    public func aes128Encrypt(withKey key: String, iv: Data? = nil) -> String? {
        return symmetricEncrypt(algorithm: .aes_128, key: key, iv: iv)
    }
    
    public func aes128Decrypt(withKey key: String, iv: Data? = nil) -> String? {
        return symmetricDecrypt(algorithm: .aes_128, key: key, iv: iv)
    }
    
    public func desEncrypt(withKey key: String, iv: Data? = nil) -> String? {
        return symmetricEncrypt(algorithm: .des, key: key, iv: iv)
    }
    
    public func desDecrypt(withKey key: String, iv: Data? = nil) -> String? {
        return symmetricDecrypt(algorithm: .des, key: key, iv: iv)
    }
}

// MARK: SymmetricCryptor
extension String {
    public func symmetricEncrypt(algorithm: SymmetricCryptorAlgorithm, key: String, iv: Data? = nil) -> String? {
        guard let clearData = self.data(using: .utf8), let keyData = key.data(using: .utf8) else {
            return nil
        }
        
        return clearData.symmetricEncrypt(algorithm: algorithm, key: keyData, iv: iv)?.base64EncodedString()
    }
    
    public func symmetricDecrypt(algorithm: SymmetricCryptorAlgorithm, key: String, iv: Data? = nil) -> String? {
        guard let cipherData = Data(base64Encoded: self), let keyData = key.data(using: .utf8) else {
            return nil
        }
        
        guard let clearData = cipherData.symmetricDecrypt(algorithm: algorithm, key: keyData, iv: iv) else {
            return nil
        }
        
        return String(data: clearData, encoding: .utf8)
    }
}
