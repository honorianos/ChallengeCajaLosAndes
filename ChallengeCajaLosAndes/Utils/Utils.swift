////
////  LoadingDialog+ViewContoller.swift
////  sagaTT
////
////  Created by Oswaldo Jeisson Escobar Huisa on 12/05/22.
////
//
//import Foundation
//import UIKit
////import CryptoSwift
//
//
//public class Utils{
//
//    static let key = "MW9waTJieTQzcHViaXQ1Mw=="
//    static let iV = "em1wMzI0NWlvNW9pNDJ6dQ=="
//    static let keyDecrypt = "1opi2by43pubit53"
//    static let ivDecrypt = "zmp3245io5oi42zu"
//    static let baseUrl = "https://www.mindicador.cl/api"
//    
//    public func showSimpleAlert(titulo: String, mensaje: String, vc: UIViewController, okBtn: String = "Aceptar"){
//        let alertOffline = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
//        alertOffline.addAction(UIAlertAction(title: okBtn, style: .default, handler: nil))
//        vc.present(alertOffline, animated: true, completion: nil)
//    }
//    
//
//
//    
//}
//
//extension String {
//    
//    func aesEncrypt() -> String {
//        
//        do {
//            
//            let iVbase64Encoded = Utils.iV
//            let iVdecodedData = Data(base64Encoded: iVbase64Encoded)!
//            let iVdecodedString = String(data: iVdecodedData, encoding: .utf8)!
//            
//            let keyBase64Encoded = Utils.key
//            let keyDecodedData = Data(base64Encoded: keyBase64Encoded)!
//            let keyDecodedString = String(data: keyDecodedData, encoding: .utf8)!
//
//            let ivData = Array((iVdecodedString).utf8)
//            let gcm = GCM(iv: ivData, additionalAuthenticatedData: nil, tagLength: 16 * 8, mode: .combined)
//            let aes = try AES(key: Array((keyDecodedString).utf8), blockMode: gcm, padding: .noPadding)
//            let encrypted = try aes.encrypt(Array(self.utf8))
//            let encryptedReturn = Data(encrypted).base64EncodedString()
//            
//            return encryptedReturn
//        } catch  {
//            return ""
//        }
//
//    }
//    
//    func aesDecrypt() -> String {
//        do {
//            let ivData = Array((Utils.ivDecrypt).utf8)
//            let gcm = GCM(iv: ivData, mode: .combined)
//            let aes = try AES(key: Array((Utils.keyDecrypt).utf8), blockMode: gcm, padding: .noPadding)
//            let result = try self.decryptBase64ToString(cipher: aes)
//            return result
//        } catch  {
//            return ""
//        }
//    }
//
//}
//
//
