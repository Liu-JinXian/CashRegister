//
//  StringExtension.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2022/5/14.
//
import CryptoSwift

extension String {
    /// AES加密
    ///
    /// - Parameters:
    ///   - key: key
    ///   - iv: iv
    /// - Returns: String
    func aesEncrypt() -> String? {
        var result: String?
        do {
            
            let key = "bentoAseEncrypt0"
            let iv = "bentoAseEncrypt0"
            
            // 用UTF8的编碼方式將字串轉成Data
            let data: Data = self.data(using: String.Encoding.utf8, allowLossyConversion: true)!
            
            // 用AES的方式將Data加密
            let aecEnc: AES = try AES(key: key, iv: iv)
            let enc = try aecEnc.encrypt(data.bytes)
            
            // 使用Base64編碼方式將Data轉回字串
            let encData: Data = Data(bytes: enc, count: enc.count)
            result = encData.base64EncodedString()
        } catch {
            print("\(error.localizedDescription)")
        }
        
        return result
    }
    
    /// AES解密
    ///
    /// - Parameters:
    ///   - key: key
    ///   - iv: iv
    /// - Returns: String
    func aesDecrypt() -> String? {
        var result: String?
        do {
            
            let key = "bentoAseEncrypt0"
            let iv = "bentoAseEncrypt0"
            
            // 使用Base64的解碼方式將字串解碼後再轉换Data
            let data = Data(base64Encoded: self, options: Data.Base64DecodingOptions(rawValue: 0))!
            
            // 用AES方式將Data解密
            let aesDec: AES = try AES(key: key, iv: iv)
            let dec = try aesDec.decrypt(data.bytes)
            
            // 用UTF8的編碼方式將解完密的Data轉回字串
            let desData: Data = Data(bytes: dec, count: dec.count)
            result = String(data: desData, encoding: .utf8)!
        } catch {
            print("\(error.localizedDescription)")
        }
        
        return result
    }
}
