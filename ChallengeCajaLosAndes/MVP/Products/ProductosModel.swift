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
    
    static func fetchCards(isFirstCall: Bool,completion: @escaping (Result<[Card], Error>) -> Void) {
        
        guard let url = URL(string: "\(UtilsAPI.baseURLMoock)\( isFirstCall ? "/products" : "/reloadProducts")") else {
            completion(.failure(NSError(domain: "URL inválida", code: 400, userInfo: nil)))
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
                let cards = try JSONDecoder().decode([Card].self, from: data)
                completion(.success(cards))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

}


