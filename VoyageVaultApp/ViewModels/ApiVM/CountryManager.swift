//
//  CountryManager.swift
//  VoyageVaultApp
//
//  Created by Nicholas Nieminen on 2024-10-24.
//

import Foundation

class CountryManager: ObservableObject {
    
    let api = Api()
    
    @Published var country: CountryApi? = nil
    
    let BASE_URL = "https://countriesnow.space"
    
    func getCountryByISO(iso: String) async throws {
        let retrivedCountry: CountryApi = try await api.post(url: "\(BASE_URL)/api/v0.1/countries/flag/images", body: iso)
        
        DispatchQueue.main.async{
            
            self.country = retrivedCountry
        }
    }
    
}
