//
//  ProductoDetallePresenter.swift
//  ChallengeCajaLosAndes
//
//  Created by Oswaldo Escobar on 4/01/25.
//

import Foundation
import UIKit

protocol ProductoDetailPresenterDelegate: AnyObject {
    func showLoader(show: Bool)
    func successResponse(account: CuentaResponse)
}


typealias PresenterProductoDetailDelegate = ProductoDetailPresenterDelegate & UIViewController

class ProductoDetallePresenter {
    weak var delegate: PresenterProductoDetailDelegate?
    private let utils = Utils()
    
    public func setViewDelegate(delegate: PresenterProductoDetailDelegate) {
        self.delegate = delegate
    }
    
    func callAccount(isFirstCall: Bool) {
        if isOnline {
            APIProductosDetalleRequest.fetchAccount(isFirstCall: isFirstCall) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let account):
                        self.delegate?.successResponse(account: account)
                    case .failure(let error):
                        self.utils.showSimpleAlert(titulo: Strings.attentionTitle, mensaje: "code: \(error.localizedDescription)", vc: self.delegate!)
                    }
                }
            }
        }
        else {
            self.utils.showSimpleAlert(titulo: Strings.attentionTitle, mensaje: Strings.noInternetMessage, vc: delegate!.self)
        }
        
    }
}

