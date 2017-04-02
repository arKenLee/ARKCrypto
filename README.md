# ARKCrypto
Notes for encryption by Swift

## Note
------
This is my personal note, not yet to release.

If you want to integrate into the project, you should importing `CommonCrypto`, [see](http://stackoverflow.com/questions/25248598/importing-commoncrypto-in-a-swift-framework/37125785#37125785)

## Features

### Digest
```
let md2 = data.md2 // md2 data
let md4 = data.md4 // md4 data
let md5 = data.md5 // md5 data

let sha1 = data.sha1     // sha1 data
let sha224 = data.sha224 // sha224 data
let sha256 = data.sha256 // sha256 data
let sha384 = data.sha384 // sha384 data
let sha512 = data.sha512 // sha512 data

let md2String = string.md2 // equal to `data.md2String`
let md4String = string.md4 // equal to `data.md4String`
let md5String = string.md5 // equal to `data.md5String`

let sha1String = string.sha1     // equal to `data.sha1String`
let sha224String = string.sha224 // equal to `data.sha224String`
let sha256String = string.sha256 // equal to `data.sha256String`
let sha384String = string.sha384 // equal to `data.sha384String`
let sha512String = string.sha512 // equal to `data.sha512String`
```
### HMAC
```
let hmacMD5    = data.hmacMD5(key: key)    // HMAC MD5 data
let hmacSHA1   = data.hmacSHA1(key: key)   // HMAC SHA1 data
let hmacSHA224 = data.hmacSHA224(key: key) // HMAC SHA224 data
let hmacSHA256 = data.hmacSHA256(key: key) // HMAC SHA256 data
let hmacSHA384 = data.hmacSHA384(key: key) // HMAC SHA384 data
let hmacSHA512 = data.hmacSHA512(key: key) // HMAC SHA512 data

let md2String = string.hmacMD5(key: keyString)       // equal to `data.hmacMD5String(key: keyString)`
let md4String = string.hmacSHA1(key: keyString)      // equal to `data.hmacSHA1String(key: keyString)`
let md5String = string.hmacSHA224(key: keyString)    // equal to `data.hmacSHA224String(key: keyString)`
let sha1String = string.hmacSHA256(key: keyString)   // equal to `data.hmacSHA256String(key: keyString)`
let sha224String = string.hmacSHA384(key: keyString) // equal to `data.hmacSHA384String(key: keyString)`
let sha256String = string.hmacSHA512(key: keyString) // equal to `data.hmacSHA512String(key: keyString)`
```

### Symmetric Encryption
```
// Data
let aesCipher = data.aes128Encrypt(withKey: key, iv: nil) // iv default is nil
let aesClear = aesCipher?.aes128Decrypt(withKey: key)     // iv default is nil

let desCipher = data.desEncrypt(withKey: key)
let desClear = desCipher?.desDecrypt(withKey: key)

let aesCipher2 = data.symmetricEncrypt(algorithm: .aes_128, key: key)       // equal to `data.aes128Encrypt(withKey: key)`
let aesClear2 = aesCipher2?.symmetricDecrypt(algorithm: .aes_128, key: key) // equal to `aesCipher?.aes128Decrypt(withKey: key)`

let rc4Cipher = data.symmetricEncrypt(algorithm: .rc4_128, key: key)
let rc4Clear = rc4Cipher?.symmetricEncrypt(algorithm: .rc4_128, key: key)


// String
let aesCiphertext = string.aes128Encrypt(withKey: keyString)         // iv default is nil
let aesCleartext = aesCiphertext?.aes128Decrypt(withKey: keyString)  // iv default is nil

let desCiphertext = string.desEncrypt(withKey: keyString)
let desCleartext = desCiphertext?.desDecrypt(withKey: keyString)

let aesCiphertext2 = string.symmetricEncrypt(algorithm: .aes_128, key: keyString)         // equal to `string.aes128Encrypt(withKey: keyString)`
let aesCleartext2 = aesCiphertext2?.symmetricDecrypt(algorithm: .aes_128, key: keyString) // equal to `aesCiphertext2?.aes128Decrypt(withKey: keyString)`

let rc4Ciphertext = string.symmetricEncrypt(algorithm: .rc4_128, key: keyString)
let rc4Cleartext = rc4Ciphertext?.symmetricEncrypt(algorithm: .rc4_128, key: keyString)
```

## Author
------
arkenlee

## License
------
ARKCrypto is available under the MIT license. See the LICENSE file for more info.
