import Foundation

class CountryManager: ObservableObject {
    
    @Published var countries: [String: CountryData] = [:]
    @Published var country: CountryData?
    @Published var city: CityData?

    let api = Api()
    
    func getCountryByIso(iso: String) async throws {
       
        let requestBody = CountryRequest(iso2: iso)
        
        
        let result: CountryApi = try await api.post(
            url: "https://countriesnow.space/api/v0.1/countries/flag/unicode",
            body: requestBody
        )
        
        
        DispatchQueue.main.async {
            self.country = result.data
            
            self.countries[iso] = result.data
        }
    }
    
    func getCityByName(cityName: String) async throws {
        let headers = ["X-Api-Key": "fmi/3TTYsipAZ6EGcBHkaQ==XdSdvitZMyCiRTpQ"]
        
      
        let result: [CityData] = try await api.get(url: "https://api.api-ninjas.com/v1/city?name=\(cityName)", headers: headers)
        
       
        DispatchQueue.main.async {
            self.city = result.first
            
            
            print("Fetched city: \(String(describing: self.city))")

        }
    }
}
