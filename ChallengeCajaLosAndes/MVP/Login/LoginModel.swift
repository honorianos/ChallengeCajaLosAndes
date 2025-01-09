//
//  LoginModel.swift
//  ChallengeCajaLosAndes
//
//  Created by Oswaldo Escobar on 3/01/25.
//

import Foundation
import UIKit

struct ErrorResponse: Error, Codable {
    struct ErrorDetail: Codable {
        struct UserMessage: Codable {
            let original: String
            let es: String
            let ja: String
        }
        let code: Int
        let userMessage: UserMessage
    }
    let error: ErrorDetail
}

struct APILoginRequest {
    static func createLoginRequest(usuario: String, contrasena: String) -> URLRequest? {
        guard let url = URL(string: UtilsAPI.baseURL) else {
            print("URL inválida")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(UtilsAPI.authorizationHeader, forHTTPHeaderField: "Authorization")
        
        let body: [String: Any] = [
            "user": [
                "usr_code": usuario,
                "pass": contrasena,
                "profile": ["language": "es"]
            ],
            "device": [
                "deviceId": UIDevice.current.identifierForVendor?.uuidString ?? "",
                "name": UIDevice.current.name,
                "version": UIDevice.current.systemVersion,
                "width": UIScreen.main.bounds.width,
                "heigth": UIScreen.main.bounds.height,
                "model": UIDevice.current.model,
                "platform": usuario == "12345678" ? "ioss" : "ios"
            ],
            "app": ["version": "1.0.0"]
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            print("Error al serializar el cuerpo de la solicitud: \(error.localizedDescription)")
            return nil
        }
        
        return request
    }
    
    static func callServiceLogin(request: URLRequest?, completion: @escaping (Result<Void, ErrorResponse>) -> Void) {
        
        guard let request = request else {
            print("Request Invalido ")
            return
        }
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    let errorResponse = createDefaultError(message: error.localizedDescription)
                    completion(.failure(errorResponse))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    let errorResponse = createDefaultError(message: Strings.unexpectedErrorMessage)
                    completion(.failure(errorResponse))
                    return
                }
                
                guard let data = data else {
                    let errorResponse = createDefaultError(message: "No se recibió respuesta del servidor.")
                    completion(.failure(errorResponse))
                    return
                }
                
                switch httpResponse.statusCode {
                case 200:
                    completion(.success(()))
                default:
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(.failure(errorResponse))
                    } catch {
                        let errorResponse = createDefaultError(message: Strings.unexpectedErrorMessage)
                        completion(.failure(errorResponse))
                    }
                }
            }
        }.resume()
    }
    
    private static func createDefaultError(message: String) -> ErrorResponse {
        return ErrorResponse(error: ErrorResponse.ErrorDetail(
            code: 500,
            userMessage: ErrorResponse.ErrorDetail.UserMessage(
                original: message,
                es: message,
                ja: message
            )
        ))
    }
}
