//
//  Data+Digest.swift
//  ARKCrypto
//
//  Created by Lee on 2017/4/2.
//  Copyright © 2017年 arKen. All rights reserved.
//

import Foundation

extension Data {
    
    // MARK: Public
    
    public var md2: Data { return digest(.md2) }
    public var md4: Data { return digest(.md4) }
    public var md5: Data { return digest(.md5) }
    
    public var sha1: Data { return digest(.sha1) }
    public var sha224: Data { return digest(.sha224) }
    public var sha256: Data { return digest(.sha256) }
    public var sha384: Data { return digest(.sha384) }
    public var sha512: Data { return digest(.sha512) }
    
    public var md2String: String { return digest(.md2) }  //! lowercase
    public var md4String: String { return digest(.md4) }  //! lowercase
    public var md5String: String { return digest(.md5) }  //! lowercase
    
    public var sha1String: String { return digest(.sha1) }      //! lowercase
    public var sha224String: String { return digest(.sha224) }  //! lowercase
    public var sha256String: String { return digest(.sha256) }  //! lowercase
    public var sha384String: String { return digest(.sha384) }  //! lowercase
    public var sha512String: String { return digest(.sha512) }  //! lowercase
    
    
    
    // MARK: Private
    
    private typealias DigestAlgorithm = ((UnsafeRawPointer?, CC_LONG, UnsafeMutablePointer<UInt8>?) -> UnsafeMutablePointer<UInt8>!)
    
    private typealias DigestLength = Int32
    
    private enum DigestType {
        case md2, md4, md5, sha1, sha224, sha256, sha384, sha512
        
        var digestOperator: (DigestAlgorithm, DigestLength) {
            switch self {
            case .md2: return (CC_MD2, CC_MD2_DIGEST_LENGTH)
            case .md4: return (CC_MD4, CC_MD4_DIGEST_LENGTH)
            case .md5: return (CC_MD5, CC_MD5_DIGEST_LENGTH)
            case .sha1: return (CC_SHA1, CC_SHA1_DIGEST_LENGTH)
            case .sha224: return (CC_SHA224, CC_SHA224_DIGEST_LENGTH)
            case .sha256: return (CC_SHA256, CC_SHA256_DIGEST_LENGTH)
            case .sha384: return (CC_SHA384, CC_SHA384_DIGEST_LENGTH)
            case .sha512: return (CC_SHA512, CC_SHA512_DIGEST_LENGTH)
            }
        }
    }
    
    // Digest
    private func digest(_ type: DigestType) -> Data {
        return digest(type) { Data(bytes: $0) }
    }
    
    private func digest(_ type: DigestType) -> String {
        return digest(type) { $0.reduce("") { $0.0.appendingFormat("%02x", $0.1) } }
    }
    
    private func digest<T>(_ type: DigestType, _ handler: ([UInt8]) -> T) -> T {
        let (algorithm, digestLength) = type.digestOperator
        var hash = [UInt8](repeating:0, count: Int(digestLength))
        let _ = withUnsafeBytes { algorithm($0, CC_LONG(count), &hash) }
        return handler(hash)
    }
}
