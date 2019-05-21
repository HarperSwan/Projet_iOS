//
//  WeatherViewController.swift
//  test_framework
//
//  Created by Viviane on 20/05/2019.
//  Copyright © 2019 m2sar. All rights reserved.
//

import UIKit
import Weather

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelTemperature: UILabel!
    
    @IBOutlet weak var imgTemps: UIImageView!
    @IBOutlet weak var labelWeaTitle: UILabel!
    @IBOutlet weak var labelWeaDescription: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var weatherClient = WeatherClient(key: "2888ec2cd2397d5e793783a09ed8cbc1")
    
    var city : City?
    var weatherNow : Any?
    var weather5 : Any?

    var tempe : Float = 0.0
    var dateNow : Date = Date()
    var datas : [String:Float] = [:]
    var weaTitle : String = ""
    var weaDescription : String = ""
    var iconTemps : UIImage?
    
    var cellNames : [String] = []
    var cellValues : [Float] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let group = DispatchGroup()
        group.enter()
        
        weatherClient.weather(for: city!, completion: { (truc) in
            
            self.weatherNow = truc
            
            //let tempe : Float = truc?.temperature ?? 0.0
            self.tempe = truc?.temperature ?? 0.0
            //self.labelTemperature.text = "\(tempe) °C"
            
            //let iconTps : UIImage = (truc?.weather[0].icon ?? nil)!
            //self.imgTemps.image = iconTps
            
            self.iconTemps = (truc?.weather[0].icon ?? nil)!
            
            self.dateNow = truc?.date ?? Date()
            
            self.datas["temperature"] = truc?.temperature ?? 0.0
            self.datas["temperatureMin"] = truc?.temperatureMin ?? 0.0
            self.datas["temperatureMax"] = truc?.temperatureMax ?? 0.0
            self.datas["pressure"] = truc?.pressure ?? 0.0
            self.datas["humidity"] = truc?.humidity ?? 0.0
           // print(truc?.weather[0].title ?? "")
            self.weaTitle = truc?.weather[0].title ?? ""
            self.weaDescription = truc?.weather[0].description ?? ""
            
            self.datas["cloudsCoverage"] = truc?.cloudsCoverage ?? 0.0
            self.datas["windSpeed"] = truc?.windSpeed ?? 0.0
            self.datas["windOrientation"] = truc?.windOrientation ?? 0.0

            
            group.leave()
            /*
             switch result {
             case .success(let granted) :
             if granted {
             print("access is granted")
             } else {
             print("access is denied")
             }
             case .failure(let error): print(error)
             }*/
            
            //print("WEATHER __________ \(truc)")
            //var truc2 = truc as! Forecast
            //temperature = truc?.temperature ?? 0.0
            //print(" temperature : \(temperature)")
            //weatherNow.append(truc ?? nil)
            
            //print("WEATHER __________ \(self.weatherNow)")
        } )
        group.wait()
        
        print("Ville : \(city)")
        print("Weather Now ____ \(weatherNow)")
        //weatherNow.temperature?
        
        imgTemps.image = iconTemps
        labelCity.text = city?.name
        labelTemperature.text = "\(tempe) °C"
        
        labelWeaTitle.text = weaTitle
        labelWeaDescription.text = weaDescription
        
        for (key,value) in datas{
            cellNames.append(key)
            cellValues.append(value)
        }
        print(cellValues)
        
        print(datas)
        
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    // number of section
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        //cell?.textLabel?.text = "salut"
        
        cell?.textLabel?.text = cellNames[indexPath.row]
        cell?.detailTextLabel?.text = String(cellValues[indexPath.row])
        /*
        for (value1,value2) in datas {
            cell?.textLabel?.text = value1
            cell?.detailTextLabel?.text = String(value2)
        }*/
        
        return cell!
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
