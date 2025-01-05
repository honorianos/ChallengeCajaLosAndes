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
   

    static func createLoginRequest(usuario: String, contrasena: String) -> URLRequest {
        let url = URL(string: UtilsAPI.baseURL)!
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
                "platform": usuario == "a" ? "ioss" : "ios"
            ],
            "app": ["version": "1.0.0"]
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        return request
    }
    
    static func callServiceLogin(request: URLRequest, completion: @escaping (Result<Void, ErrorResponse>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    let errorResponse = ErrorResponse(error: ErrorResponse.ErrorDetail(code: 500, userMessage: ErrorResponse.ErrorDetail.UserMessage(original: Strings.unexpectedErrorMessage, es: Strings.unexpectedErrorMessage, ja: Strings.unexpectedErrorMessage)))
                    completion(.failure(errorResponse))
                }
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                DispatchQueue.main.async {
                    switch httpResponse.statusCode {
                    case 200:
                        completion(.success(()))
                    default:
                        do {
                            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                            completion(.failure(errorResponse))
                        } catch {
                            let defaultError = ErrorResponse(error: ErrorResponse.ErrorDetail(code: 500, userMessage: ErrorResponse.ErrorDetail.UserMessage(original: Strings.unexpectedErrorMessage, es: Strings.unexpectedErrorMessage, ja: Strings.unexpectedErrorMessage)))
                            completion(.failure(defaultError))
                        }
                    }
                }
            }
        }.resume()
    }

}
