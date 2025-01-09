//
//  ProductosModel.swift
//  ChallengeCajaLosAndes
//
//  Created by Oswaldo Escobar on 4/01/25.
//

import Foundation
import UIKit

struct Card: Codable {
    let cardType: String
    let cardNumber: String
    let expiry: String
    let name: String
}

struct APIProductosRequest {
    
    static func fetchCards(isFirstCall: Bool, completion: @escaping (Result<[Card], Error>) -> Void) {
        
        guard let url = URL(string: "\(UtilsAPI.baseURLMoock)\(isFirstCall ? "/products" : "/reloadProducts")") else {
            completion(.failure(createDefaultError(message: "URL inválida.")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(createDefaultError(message: "Respuesta no válida del servidor.")))
                    return
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    let errorDescription = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
                    completion(.failure(createDefaultError(message: "Error HTTP: \(errorDescription) (\(httpResponse.statusCode))")))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(createDefaultError(message: "Datos no válidos o vacíos recibidos del servidor.")))
                    return
                }
                
                do {
                    let cards = try JSONDecoder().decode([Card].self, from: data)
                    completion(.success(cards))
                } catch let decodingError {
                    completion(.failure(createDefaultError(message: "Error al decodificar los datos: \(decodingError.localizedDescription)")))
                }
            }
        }.resume()
    }
    
    
    private static func createDefaultError(message: String) -> NSError {
        return NSError(domain: "com.challengeCajaLosAndes", code: 500, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
