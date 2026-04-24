//
//  NetworkService.swift
//  Eisenhower
//
//  Created by Bee Wijaya on 21/04/26.
//

import SwiftUI

enum NetworkError: Error {
    case unauthorized(String)           // 401
    case forbidden(String)              // 403
    case notFound(String)               // 404
    case serverError(Int, String)       // 5xx
    case unknown(Int, String)           // anything else
    
    var message: String {
        switch self {
        case .unauthorized(let message),
                .forbidden(let message),
                .notFound(let message):
            return message
        case .serverError(_, let message),
                .unknown(_, let message):
            return message
        }
    }
}

class NetworkService {
    // MARK: - App Storage
    @AppStorage("token") var token: String?
    
    // MARK: - State
    private var host = "http://localhost:9000"
    
    func get(path: String) async throws -> Data {
        guard let url = URL(string: "\(host)/\(path)") else {
            throw URLError(.badURL)
        }
        let tok = token ?? ""
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(tok.trimmingCharacters(in: .whitespacesAndNewlines))", forHTTPHeaderField: "Authorization")
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let err = check(data: data, response: response) {
            throw err
        }
        
        return data
    }
    
    
    func post(path: String, body: Data) async throws -> Data {
        guard let url = URL(string: "\(host)/\(path)") else {
            throw URLError(.badURL)
        }
        let tok = token ?? ""
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if tok != "" {
            request.setValue("Bearer \(tok.trimmingCharacters(in: .whitespacesAndNewlines))", forHTTPHeaderField: "Authorization")
        }

        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let err = check(data: data, response: response) {
            throw err
        }
        
        
        return data
    }
    
    func check(data: Data, response: URLResponse) -> NetworkError? {
        if let http = response as? HTTPURLResponse {
            let apiError = (try? JSONDecoder().decode(APIError.self, from: data))?.message ?? "Something went wrong"
            switch http.statusCode {
            case 200...299: break
            case 401: return NetworkError.unauthorized(apiError)
            case 403: return NetworkError.forbidden(apiError)
            case 404: return NetworkError.notFound(apiError)
            case 500: return NetworkError.serverError(http.statusCode, apiError)
            default: return NetworkError.unknown(http.statusCode, apiError)
            }
        }
        
        return nil
    }
}
