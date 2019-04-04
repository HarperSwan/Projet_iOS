import Foundation

struct allWeather : Codable {
    
    // BEGIN Weather
    struct weatherItem : Codable {
        let main: String
        let description: String
        
        init(){
            self.main = ""
            self.description = ""
        }
        
        enum CodingKeys: String, CodingKey {
            case main, description
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.main = try container.decode(String.self, forKey: .main) ?? ""
            self.description = try container.decode(String.self, forKey: .description) ?? ""
        }
    }
    // END Weather
    
    // BEGIN Main
    struct mainItem: Codable{
        let temp: Float
        let pressure: Int
        let humidity: Int
        let temp_min: Float
        let temp_max: Float
        
        init(){
            self.temp = 0.0
            self.pressure = 0
            self.humidity = 0
            self.temp_min = 0.0
            self.temp_max = 0.0
        }
        
        enum CodingKeys: String, CodingKey{
            case temp, pressure, humidity, temp_min, temp_max
        }
        
        init(from decoder:Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.temp = try container.decode(Float.self, forKey: .temp) ?? 0.0
            self.pressure = try container.decode(Int.self, forKey: .pressure) ?? 0
            self.humidity = try container.decode(Int.self, forKey: .humidity) ?? 0
            self.temp_min = try container.decode(Float.self, forKey: .temp_min) ?? 0.0
            self.temp_max = try container.decode(Float.self, forKey: .temp_max) ?? 0.0
        }
    }
    // END Main
    
    // BEGIN wind
    struct windItem: Codable {
        let speed: Float
        let deg: Float
        
        init(){
            self.speed = 0.0
            self.deg = 0.0
        }
        
        enum CodingKeys: String, CodingKey{
            case speed, deg
        }
        
        init(from decoder:Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.speed = try container.decode(Float.self, forKey: .speed) ?? 0.0
            self.deg = try container.decode(Float.self, forKey: .deg) ?? 0.0
        }
    }
    // END wind
    
    // BEGIN Clouds
    struct cloudsItem: Codable{
        let all: Int
        
        init(){
            self.all = 0
        }
        
        enum CodingKeys: String,CodingKey{
            case all
        }
        
        init(from decoder:Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.all = try container.decode(Int.self, forKey: .all) ?? 0
        }
    }
    // END Clouds
    
    // BEGIN rain
    struct rainItem: Codable{
        let one: Float
        let three: Float
        
        init(){
            self.one = 0.0
            self.three = 0.0
        }
        
        enum CodingKeys: String, CodingKey{
            case one = "1h"
            case three = "3h"
        }
        
        init(from decoder:Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.one = try container.decode(Float.self, forKey: .one) ?? 0.0
            self.three = try container.decode(Float.self, forKey: .three) ?? 0.0
        }
    }
    // END rain
    
    // BEGIN snow
    struct snowItem: Codable{
        let one: Float
        let three: Float
        
        init(){
            self.one = 0.0
            self.three = 0.0
        }
        
        enum CodingKeys: String, CodingKey{
            case one = "1h"
            case three = "3h"
        }
        
        init(from decoder:Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.one = try container.decode(Float.self, forKey: .one) ?? 0.0
            self.three = try container.decode(Float.self, forKey: .three) ?? 0.0
        }
    }
    // END snow
    
    let WeatherItem: [weatherItem]
    let MainItem: mainItem
    let WindItem: windItem
    let RainItem: rainItem
    let CloudsItem: cloudsItem
    let SnowItem: snowItem
    let dt: Int
    let dt_txt: String
    let name: String
    
    enum CodingKeys: String,CodingKey{
        case WeatherItem, MainItem, WindItem, RainItem, CloudsItem, SnowItem, dt, dt_txt, name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.WeatherItem = try container.decodeIfPresent([weatherItem].self, forKey: .WeatherItem) ?? [weatherItem()]
        self.MainItem = try container.decodeIfPresent(mainItem.self,forKey: .MainItem) ?? mainItem()
        self.WindItem = try container.decodeIfPresent(windItem.self, forKey: .WindItem) ?? windItem()
        self.RainItem = try container.decodeIfPresent(rainItem.self, forKey: .RainItem) ?? rainItem()
        self.CloudsItem = try container.decodeIfPresent(cloudsItem.self, forKey: .CloudsItem) ?? cloudsItem()
        self.SnowItem = try container.decodeIfPresent(snowItem.self, forKey: .SnowItem) ?? snowItem()
        self.dt = try container.decodeIfPresent(Int.self, forKey: .dt) ?? 0
        self.dt_txt = try container.decodeIfPresent(String.self, forKey: .dt_txt) ?? ""
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
}

// Search city
func meteo_by_city2(city:String) -> Void {
    
    // queries
    var query: [String: String] = [
        "appid" : "2888ec2cd2397d5e793783a09ed8cbc1"
    ] // query with API key
    
    // Adding city to queries
    query["q"] = city
    
    // url
    let baseUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?")! // URL de base
    
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
            
            // Encode
            let jsonR = try? JSONDecoder().decode(allWeather.self,from:data)
            //print(jsonR)
        } catch {
            print("Error")
            return
        }
        
    })
    task.resume()
    sem.wait()
}

