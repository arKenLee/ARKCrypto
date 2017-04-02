//
//  Data+HMAC.swift
//  ARKCrypto
//
//  Created by Lee on 2017/4/2.
//  Copyright © 2017年 arKen. All rights reserved.
//

import Foundation

// MARK: HMAC
extension Data {
    
    // MARK: Public
    
    public func hmacMD5(key: Data) -> Data { return sign(.md5, key) }
    public func hmacSHA1(key: Data) -> Data { return sign(.sha1, key) }
    public func hmacSHA224(key: Data) -> Data { return sign(.sha224, key) }
    public func hmacSHA256(key: Data) -> Data { return sign(.sha256, key) }
    public func hmacSHA384(key: Data) -> Data { return sign(.sha384, key) }
    public func hmacSHA512(key: Data) -> Data { return sign(.sha512, key) }
    
    public func hmacMD5String(key: String) -> String? { return sign(.md5, key) }       //! lowercase
    public func hmacSHA1String(key: String) -> String? { return sign(.sha1, key) }     //! lowercase
    public func hmacSHA224String(key: String) -> String? { return sign(.sha224, key) } //! lowercase
    public func hmacSHA256String(key: String) -> String? { return sign(.sha256, key) } //! lowercase
    public func hmacSHA384String(key: String) -> String? { return sign(.sha384, key) } //! lowercase
    public func hmacSHA512String(key: String) -> String? { return sign(.sha512, key) } //! lowercase
    
    
    // MARK: Private
    
    private typealias DigestLength = Int
    
    private enum HMACType {
        case md5, sha1, sha224, sha256, sha384, sha512
        
        var hmacOperator: (CCHmacAlgorithm, DigestLength) {
            switch self {
            case .md5: return (CCHmacAlgorithm(kCCHmacAlgMD5), Int(CC_MD5_DIGEST_LENGTH))
            case .sha1: return (CCHmacAlgorithm(kCCHmacAlgSHA1), Int(CC_SHA1_DIGEST_LENGTH))
            case .sha224: return (CCHmacAlgorithm(kCCHmacAlgSHA224), Int(CC_SHA224_DIGEST_LENGTH))
            case .sha256: return (CCHmacAlgorithm(kCCHmacAlgSHA256), Int(CC_SHA256_DIGEST_LENGTH))
            case .sha384: return (CCHmacAlgorithm(kCCHmacAlgSHA384), Int(CC_SHA384_DIGEST_LENGTH))
            case .sha512: return (CCHmacAlgorithm(kCCHmacAlgSHA512), Int(CC_SHA512_DIGEST_LENGTH))
            }
        }
    }
    
    // Sign
    private func sign(_ type: HMACType, _ key: Data) -> Data {
        return sign(type, key) {
            Data(bytes: $0)
        }
    }
    
    private func sign(_ type: HMACType, _ key: String) -> String? {
        return key.data(using: .utf8).map {
            sign(type, $0) {
                $0.reduce("") {
                    $0.0.appendingFormat("%02x", $0.1)
                }
            }
        }
    }
    
    private func sign<T>(_ type: HMACType, _ key: Data, _ handler: ([UInt8]) -> T) -> T {
        let (algorithm, digestLength) = type.hmacOperator
        var signature = [UInt8](repeating:0, count: Int(digestLength))
        
        withUnsafeBytes { dataBytes in
            key.withUnsafeBytes { keyBytes in
                CCHmac(algorithm, keyBytes, key.count, dataBytes, count, &signature)
            }
        }
        
        return handler(signature)
    }
}
