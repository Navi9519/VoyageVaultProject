//
//  Api.swift
//  VoyageVaultApp
//
//  Created by Nicholas Nieminen on 2024-10-24.
//

import Foundation

class Api {
    
    func get<R: Decodable>(url: String) async throws -> R {
        
        //Validera URL
        guard let url = URL(string: url) else {throw APIError.invalidURL}
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 205 else { throw APIError.invalidResponse}
        
        do {
            let decoder = JSONDecoder()
            
            let decodedResponse = try decoder.decode(R.self, from: data)
            
            return decodedResponse
        } catch {
            throw APIError.invalidData
        }
        
    }
}


enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
