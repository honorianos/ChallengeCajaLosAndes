//
//  ProductosPresenter.swift
//  ChallengeCajaLosAndes
//
//  Created by Oswaldo Escobar on 4/01/25.
//


import Foundation
import UIKit

protocol ProductosPresenterDelegate: AnyObject {
    func showLoader(show: Bool)
    func successResponse(array: [Card])
}

typealias PresenterProductorDelegate = ProductosPresenterDelegate & UIViewController

class ProductosPresenter {
    weak var delegate: PresenterProductorDelegate?
    private let utils = Utils()
    
    public func setViewDelegate(delegate: PresenterProductorDelegate) {
        self.delegate = delegate
    }
    
    func callProducts(isFirstCall: Bool) {
        self.delegate?.showLoader(show: true)
        if isOnline {
            APIProductosRequest.fetchCards(isFirstCall: isFirstCall) { result in
                self.delegate?.showLoader(show: false)
                DispatchQueue.main.async {
                    switch result {
                    case .success(let cards):
                        self.delegate?.successResponse(array: cards)
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
