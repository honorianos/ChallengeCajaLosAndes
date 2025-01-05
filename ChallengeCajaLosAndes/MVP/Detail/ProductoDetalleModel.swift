//
//  ProductoDetalleModel.swift
//  ChallengeCajaLosAndes
//
//  Created by Oswaldo Escobar on 4/01/25.
//

import Foundation
import UIKit

struct CuentaResponse: Decodable {
    struct Cuenta: Decodable {
        let tipo: String
        let saldo: String
        let numeroCuenta: String
        let urlImage: String
        let pin: String
    }
    struct Movimiento: Decodable {
        let descripcion: String
        let fecha: String
        let monto: String
        let moneda: String
        let tipo: String
    }
    
    let cuenta: Cuenta
    let movimientos: [Movimiento]
}

struct APIProductosDetalleRequest {
    
    static func fetchAccount(isFirstCall: Bool,completion: @escaping (Result<CuentaResponse, Error>) -> Void) {
        
        guard let url = URL(string: "\(UtilsAPI.baseURLMoock)\( isFirstCall ? "/detailProduct" : "/reloadDetailProduct")") else {
            completion(.failure(NSError(domain: "URL inválida", code: 500, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Datos no válidos", code: 500, userInfo: nil)))
                return
            }
            
            do {
                let cards = try JSONDecoder().decode(CuentaResponse.self, from: data)
                completion(.success(cards))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}


