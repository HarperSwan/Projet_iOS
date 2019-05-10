import Foundation


func meteo_by_city_for5days(city:String){
    //let url = add_city_url(city: city, condition: "forcast")
    
    // queries
    var query: [String: String] = [
        "appid" : "2888ec2cd2397d5e793783a09ed8cbc1"
    ] // query with API key
    
    // Adding city to queries
    query["q"] = city
    
    // url
    let baseUrl = URL(string: "https://api.openweathermap.org/data/2.5/forecast?")! // URL de base
    
    // Adding queries to URL
    let url = baseUrl.withQueries(query)!
    
    print(url)
    
    // HTTP request
    // Récupération données
    let task = URLSession.shared.dataTask(with: url, completionHandler:  {(data,response,error) in
        
        // verify error
        guard error == nil else {
            print("error calling GET on /weather")
            print(error!)
            return
        }
        // make sure we got data in the response
        guard let data = data else {
            print("Error: did not receive data")
            return
        }
        do{
            //here dataResponse received from a network request
            let jsonResponse = try JSONSerialization.jsonObject(with:data, options: [])
            //print(jsonResponse)
            
            if let array = jsonResponse as? Array {
                for obj in array {
                    if let dict = obj as? NSDictionary {
                        // Now reference the data you need using:
                        let id = dict.valueForKey("id")
                    }
                }
            }
            
            // Encode
            //let jsonR = try? JSONDecoder().decode(allWeather.self,from:data)
            //print(jsonR)
        } catch {
            print("Error")
            return
        }
        
    })
    task.resume()
}

func add_city_url(city:String, condition:String){
    /*
     // queries
     var query: [String: String] = [
     "appid" : "2888ec2cd2397d5e793783a09ed8cbc1"
     ] // query with API key
     
     // Adding city to queries
     query["q"] = city
     
     // url
     if (condition == "weather"){
     var baseUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?")! // URL de base
     
     let url = baseUrl.withQueries(query)!
     
     return url
     } else if (condition == "forcast"){
     var baseUrl = URL(string: "https://api.openweathermap.org/data/2.5/forcast?")! // URL de base
     
     let url = baseUrl.withQueries(query)!
     
     return url
     } else {
     
     }*/
}
