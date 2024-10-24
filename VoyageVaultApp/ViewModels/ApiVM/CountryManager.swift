import Foundation

class CountryManager: ObservableObject {
    @Published var country: CountryData?  // Updated to store CountryData (name and flag)

    let api = Api()
    
    func getCountryByName(countryName: String) async throws {
        // Create the request body struct
        let requestBody = CountryRequest(country: countryName)
        
        // Call the post method, sending the `CountryRequest` as the body
        let result: CountryApi = try await api.post(
            url: "https://countriesnow.space/api/v0.1/countries/flag/unicode",
            body: requestBody  // This sends the struct as JSON
        )
        
        // Access the nested data for country and flag
        DispatchQueue.main.async {
            self.country = result.data  // result.data contains the CountryData (name, flag)
        }
    }
}
