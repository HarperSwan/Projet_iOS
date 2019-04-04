import Foundation

// Variables
/*
let baseUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?")! // URL de base
var query: [String: String] = [
    "appid" : "2888ec2cd2397d5e793783a09ed8cbc1"
] // query avec clé API
*/
// Extension // Function create URL
extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self,
                                       resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map {
            URLQueryItem(name: $0.0, value: $0.1)
        }
        return components?.url
    }
}
/*
func sendRequest (request:URLRequest,completion:(NSData?)->()){
    URLSession.sharedSession.dataTaskWithRequest(request as URLRequest){
        data,response, error in
        if error != nil{
            return completion(data)
        } else {
            return completion(nil)
        }
    }.resume()
}*/

// Adding queries to URL
//let url = baseUrl.withQueries(query)!

