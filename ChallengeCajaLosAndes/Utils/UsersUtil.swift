//
//  UsersUtil.swift
//  sagaTT
//
//  Created by Oswaldo Jeisson Escobar Huisa on 12/05/22.
//

import Foundation

class UsersUtil {
    static let keychain = KeychainSwift()
    static func initBd() {
        UsersUtil.keychain.set(Users.Usuario, forKey: Users.keyUsuario)
        UsersUtil.keychain.set(Users.Password, forKey: Users.keyPassword)
    }
    static func validateLogin(username: String, password: String) -> Bool {
        if (keychain.get(Users.keyUsuario) == username && keychain.get(Users.keyPassword) == password ) {
            return true
        }
        return false
    }
}
