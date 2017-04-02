//
//  String+Digest.swift
//  ARKCrypto
//
//  Created by Lee on 2017/4/2.
//  Copyright © 2017年 arKen. All rights reserved.
//

import Foundation

extension String {
    
    // MARK: Lowercase
    
    public var md2: String?    { return data(using: .utf8)?.md2String }
    public var md4: String?    { return data(using: .utf8)?.md4String }
    public var md5: String?    { return data(using: .utf8)?.md5String }
    
    public var sha1:   String? { return data(using: .utf8)?.sha1String  }
    public var sha224: String? { return data(using: .utf8)?.sha224String  }
    public var sha256: String? { return data(using: .utf8)?.sha256String  }
    public var sha384: String? { return data(using: .utf8)?.sha384String  }
    public var sha512: String? { return data(using: .utf8)?.sha512String  }
}
