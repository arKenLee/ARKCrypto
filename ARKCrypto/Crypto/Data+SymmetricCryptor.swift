//
//  Data+SymmetricCryptor.swift
//  ARKCrypto
//
//  Created by Lee on 2017/4/2.
//  Copyright © 2017年 arKen. All rights reserved.
//

import Foundation

// MARK: Convenient
extension Data {
    public func aes128Encrypt(withKey key: Data, iv: Data? = nil) -> Data? {
        return symmetricEncrypt(algorithm: .aes_128, key: key, iv: iv)
    }
    
    public func aes128Decrypt(withKey key: Data, iv: Data? = nil) -> Data? {
        return symmetricDecrypt(algorithm: .aes_128, key: key, iv: iv)
    }
    
    public func desEncrypt(withKey key: Data, iv: Data? = nil) -> Data? {
        return symmetricEncrypt(algorithm: .des, key: key, iv: iv)
    }
    
    public func desDecrypt(withKey key: Data, iv: Data? = nil) -> Data? {
        return symmetricDecrypt(algorithm: .des, key: key, iv: iv)
    }
}

// MARK: SymmetricCryptor
extension Data {
    
    public func symmetricEncrypt(algorithm: SymmetricCryptorAlgorithm, key: Data, iv: Data? = nil) -> Data? {
        return crypt(op: CCOperation(kCCEncrypt), alg: algorithm, key: key, iv: iv)
    }
    
    public func symmetricDecrypt(algorithm: SymmetricCryptorAlgorithm, key: Data, iv: Data? = nil) -> Data? {
        return crypt(op: CCOperation(kCCDecrypt), alg: algorithm, key: key, iv: iv)
    }
    
    
    private func crypt(op :CCOperation, alg: SymmetricCryptorAlgorithm, key: Data, iv: Data?) -> Data? {
        if (iv != nil && iv?.count != alg.blockSize) {
            return nil
        }
        
        if op == CCOperation(kCCDecrypt) && alg.blockSize != 0 && self.count % alg.blockSize != 0 {
            return nil
        }
        
        let options = (((iv == nil) ? kCCOptionECBMode : 0) | kCCOptionPKCS7Padding)
        let keyBytes: UnsafePointer<UInt8> = key.withUnsafeBytes { $0 }
        
        let ivBytes: UnsafePointer<UInt8>? = iv?.withUnsafeBytes { $0 }
        
        let dataLength = self.count
        let dataBytes: UnsafePointer<UInt8> = self.withUnsafeBytes { $0 }
        
        let bufferLength = dataLength + alg.blockSize
        var bufferData = Data(count: bufferLength)
        let bufferPointer: UnsafeMutablePointer<UInt8> = bufferData.withUnsafeMutableBytes { $0 }
        
        var size = 0
        
        let status = CCCrypt(
            op,
            alg.algorithm,
            CCOptions(options),
            keyBytes, alg.keySize,
            ivBytes,
            dataBytes, dataLength,
            bufferPointer, bufferLength,
            &size
        )
        
        if status != CCCryptorStatus(kCCSuccess) {
            return nil
        }
        
        bufferData.count = size
        return bufferData
    }
}

private extension SymmetricCryptorAlgorithm {
    var algorithm: CCAlgorithm {
        switch self {
        case .aes_128:   return CCAlgorithm(kCCAlgorithmAES)
        case .aes_192:   return CCAlgorithm(kCCAlgorithmAES)
        case .aes_256:   return CCAlgorithm(kCCAlgorithmAES)
        case .des:       return CCAlgorithm(kCCAlgorithmDES)
        case .des40:     return CCAlgorithm(kCCAlgorithmDES)
        case .tripleDES: return CCAlgorithm(kCCAlgorithm3DES)
        case .rc4_40:    return CCAlgorithm(kCCAlgorithmRC4)
        case .rc4_128:   return CCAlgorithm(kCCAlgorithmRC4)
        case .rc2_40:    return CCAlgorithm(kCCAlgorithmRC2)
        case .rc2_128:   return CCAlgorithm(kCCAlgorithmRC2)
        }
    }
    
    var keySize: Int {
        switch self {
        case .aes_128:   return kCCKeySizeAES128
        case .aes_192:   return kCCKeySizeAES192
        case .aes_256:   return kCCKeySizeAES256
        case .des:       return kCCKeySizeDES
        case .des40:     return 5 // 40 bits = 5 * 8
        case .tripleDES: return kCCKeySize3DES
        case .rc4_40:    return 5
        case .rc4_128:   return 16 // RC4 128 bits = 16 bytes
        case .rc2_40:    return 5
        case .rc2_128:   return kCCKeySizeMaxRC2
        }
    }
    
    var blockSize: Int {
        switch self {
        case .aes_128:   return kCCBlockSizeAES128
        case .aes_192:   return kCCBlockSizeAES128
        case .aes_256:   return kCCBlockSizeAES128
        case .des:       return kCCBlockSizeDES
        case .des40:     return kCCBlockSizeDES
        case .tripleDES: return kCCBlockSize3DES
        case .rc4_40:    return 0
        case .rc4_128:   return 0
        case .rc2_40:    return kCCBlockSizeRC2
        case .rc2_128:   return kCCBlockSizeRC2
        }
    }
}
