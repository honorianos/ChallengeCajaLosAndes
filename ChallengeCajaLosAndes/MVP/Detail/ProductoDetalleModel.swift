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
    
    static func fetchAccount(isFirstCall: Bool, completion: @escaping (Result<CuentaResponse, Error>) -> Void) {
        guard let url = URL(string: "\(UtilsAPI.baseURLMoock)\(isFirstCall ? "/detailProduct" : "/reloadDetailProduct")") else {
            completion(.failure(NSError(domain: "URL inválida", code: 400, userInfo: [NSLocalizedDescriptionKey: "URL inválida."])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                guard (200...299).contains(httpResponse.statusCode) else {
                    let errorDescription = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
                    completion(.failure(NSError(domain: "HTTP Error", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorDescription])))
                    return
                }
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Datos no válidos", code: 500, userInfo: [NSLocalizedDescriptionKey: "No se recibieron datos del servidor."])))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(CuentaResponse.self, from: data)
                completion(.success(decodedResponse))
            } catch let decodingError {
                completion(.failure(NSError(domain: "Decoding Error", code: 500, userInfo: [NSLocalizedDescriptionKey: "Error al decodificar la respuesta: \(decodingError.localizedDescription)"])))
            }
            
        }.resume()
    }
}
