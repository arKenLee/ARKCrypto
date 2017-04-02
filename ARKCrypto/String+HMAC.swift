//
//  String+HMAC.swift
//  ARKCrypto
//
//  Created by Lee on 2017/4/2.
//  Copyright © 2017年 arKen. All rights reserved.
//

import Foundation

extension String {
    
    // MARK: Lowercase 
    
    public func hmacMD5(key: String) -> String? {
        return data(using: .utf8)?.hmacMD5String(key: key)
    }
    
    public func hmacSHA1(key: String) -> String? {
        return data(using: .utf8)?.hmacSHA1String(key: key)
    }
    
    public func hmacSHA224(key: String) -> String? {
        return data(using: .utf8)?.hmacSHA224String(key: key)
    }
    
    public func hmacSHA256(key: String) -> String? {
        return data(using: .utf8)?.hmacSHA256String(key: key)
    }
    
    public func hmacSHA384(key: String) -> String? {
        return data(using: .utf8)?.hmacSHA384String(key: key)
    }
    
    public func hmacSHA512(key: String) -> String? {
        return data(using: .utf8)?.hmacSHA512String(key: key)
    }
}
