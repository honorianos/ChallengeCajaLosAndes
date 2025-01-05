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
        if username.isEmpty || password.isEmpty {
            self.utils.showSimpleAlert(titulo: Strings.attentionTitle, mensaje: Strings.invalidDataMessage, vc: delegate!.self)
        } else {
            if isOnline {
                self.delegate?.showLoader(show: true)
                iniciarSesion(usuario: username, contrasena: password)
            } else {
                self.utils.showSimpleAlert(titulo: Strings.attentionTitle, mensaje: Strings.noInternetMessage, vc: delegate!.self)
            }
        }
    }
    
    private func iniciarSesion(usuario: String, contrasena: String) {
        let request = APILoginRequest.createLoginRequest(usuario: usuario, contrasena: contrasena)
        APILoginRequest.callServiceLogin(request: request) { result in
            self.delegate?.showLoader(show: false)
            switch result {
            case .success:
                self.delegate?.successResponse()
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
