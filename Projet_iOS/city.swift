// Old file. No longer use

import Foundation

struct cityItem : Decodable {
   // let coord_lon: Float
  //  let coord_lat: Float
    let id: Int
    let sys_country: String
    let name: String
    
    init() {
    //  self.coord_lon = 0.0
    // self.coord_lat = 0.0
        self.id = 0
        self.sys_country = ""
        self.name = ""
    }

    enum CodingKeys: String,CodingKey{
    //    case coord_lon = "coord.lon"
    //    case coord_lat = "coord.lat"
        case id = "id"
        case sys_country = "case.country"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        // define container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        //self.coord_lon = try container.decode(Float.self, forKey: .coord_lon)
        //self.coord_lat = try container.decode(Float.self, forKey: .coord_lat)
        self.id = try container.decode(Int.self, forKey: .id)
        self.sys_country = try container.decode(String.self, forKey: .sys_country)
        self.name = try container.decode(String.self, forKey: .name)
        
        //self.init(coord_lon: coord_lon, coord_lat: coord_lat, id: id, sys_country: sys_country, name: name)
    }
}

// Search city
func meteo_by_city(city:String) -> Void {
    
    // Var
    let baseUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?")! // URL de base
    var query: [String: String] = [
        "appid" : "2888ec2cd2397d5e793783a09ed8cbc1"
    ] // query with clé API
    
    // Adding city to queries
    query["q"] = city
    
    // Adding queries to URL
    let url = baseUrl.withQueries(query)!
    
    print(url)
    
    // HTTP request
    // Récupération données
    let sem = DispatchSemaphore(value:0)
    
    let task = URLSession.shared.dataTask(with: url, completionHandler:  {(data,response,error) in
        
        sem.signal()
        
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
            print(jsonResponse)
            print("test")
            
           let jsonR = try? JSONDecoder().decode(cityItem.self,from:data)
           print(jsonR)
           print("test2")
            //let city = try? JSONDecoder().decode(city,from:dataResponse)
            
            //let decoder = JSONDecoder()
            //let model = try decoder.decode([city].self, from:dataResponse) //Decode JSON Response Data
//            let goodData = try? JSONDecoder().decode(cityItem.self, from: dataResponse)
//                print(goodData)
            
            /*
            guard let goodData = try? JSONDecoder().decode(city,from:dataResponse) else {
                print("Je suis pas content, ça ne marche pas :c")
                return
            }
            print(goodData)*/
            
            //print(city)
        } catch {
            print("Error")
            return
        }
        /*
         if let data = data, let string = String(data: data, encoding: .utf8) {
         print(string) // JSONSerialization
         }*/
        //}

    })
    task.resume()
    sem.wait()
    
}

