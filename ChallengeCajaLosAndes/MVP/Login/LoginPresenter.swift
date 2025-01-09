//
//  LoginPresenter.swift
//  ChallengeCajaLosAndes
//
//  Created by Oswaldo Escobar on 3/01/25.
//
import Foundation
import UIKit

struct Strings {
    static let attentionTitle = "Atención"
    static let invalidDataMessage = "Datos no válidos"
    static let noInternetMessage = "Sin Internet"
    static let unexpectedErrorMessage = "Sucedió un error inesperado."
    static let invalidCredentialsMessage = "Usuario y/o contraseña incorrectos."
}

protocol LoginPresenterDelegate: AnyObject {
    func showLoader(show: Bool)
    func successResponse()
}

typealias PresenterDelegate = LoginPresenterDelegate & UIViewController

class LoginPresenter {
    weak var delegate: PresenterDelegate?
    private let utils = Utils()
    
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    public func validateLogin(username: String, password: String) {
        let regex = "^[0-9]{8}$"
        let dniPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        if isOnline && dniPredicate.evaluate(with: username) {
            self.delegate?.showLoader(show: true)
            iniciarSesion(usuario: username, contrasena: password)
        } else {
            self.utils.showSimpleAlert(titulo: Strings.attentionTitle, mensaje: isOnline ? Strings.invalidDataMessage : Strings.noInternetMessage, vc: self.delegate!)
        }
    }

    func guardarUsuario(dni: String, nombre: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(["dni": dni, "password": nombre], forKey: "usuario")
    }
    
    private func iniciarSesion(usuario: String, contrasena: String) {
        let request = APILoginRequest.createLoginRequest(usuario: usuario, contrasena: contrasena)
        APILoginRequest.callServiceLogin(request: request) { result in
            self.delegate?.showLoader(show: false)
            switch result {
            case .success:
                self.delegate?.successResponse()
                self.guardarUsuario(dni: usuario, nombre: contrasena)
            case .failure(let errorResponse):
                self.utils.showSimpleAlert(
                    titulo: "\(Strings.attentionTitle) code: \(errorResponse.error.code)",
                    mensaje: errorResponse.error.userMessage.es,
                    vc: (self.delegate!.self)
                )
            }
        }
    }
}
