import Foundation

class CountryManager: ObservableObject {
    
    // Denna kan vara onödig, behövs eventuellt inte eftersom vi har country: CountryData som sparar samma sak
    // Dictionary to hold country data keyed by ISO code
        @Published var countries: [String: CountryData] = [:]
    
    @Published var country: CountryData?  // Updated to store CountryData (name and flag)
    @Published var city: CityData?

    let api = Api()
    
    func getCountryByIso(iso: String) async throws {
        // Create the request body struct
        let requestBody = CountryRequest(iso2: iso)
        
        // Call the post method, sending the `CountryRequest` as the body
        let result: CountryApi = try await api.post(
            url: "https://countriesnow.space/api/v0.1/countries/flag/unicode",
            body: requestBody  // This sends the struct as JSON
        )
        
        // Access the nested data for country and flag
        DispatchQueue.main.async {
            self.country = result.data  // result.data contains the CountryData (name, flag)
            
            // Denna kan vara onödig, behövs eventuellt inte eftersom vi har country: CountryData som sparar samma sak
            self.countries[iso] = result.data
        }
    }
    
    func getCityByName(cityName: String) async throws {
        let headers = ["X-Api-Key": "fmi/3TTYsipAZ6EGcBHkaQ==XdSdvitZMyCiRTpQ"]
        
        // Call the post method, sending the `CountryRequest` as the body
        let result: [CityData] = try await api.get(url: "https://api.api-ninjas.com/v1/city?name=\(cityName)", headers: headers)
        
        // Access the nested data for country and flag
        DispatchQueue.main.async {
            self.city = result.first  // result.data contains the CountryData (name, flag)
            
            
            print("Fetched city: \(String(describing: self.city))") // Debugging output

        }
    }
}
