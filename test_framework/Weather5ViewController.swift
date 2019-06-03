//
//  Weather5ViewController.swift
//  test_framework
//
//  Created by Viviane on 27/05/2019.
//  Copyright © 2019 m2sar. All rights reserved.
//

import UIKit
import Weather

class Weather5ViewController: UIViewController {
    
    // Nav bar
    @IBOutlet weak var btnRetour: UIBarButtonItem!
    
    // Values
    @IBOutlet weak var labelCity: UILabel!
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var temp1: UILabel!
    @IBOutlet weak var weaTitle1: UILabel!
    
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var temp2: UILabel!
    @IBOutlet weak var weaTitle2: UILabel!
    
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var temp3: UILabel!
    @IBOutlet weak var weaTitle3: UILabel!
    
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var temp4: UILabel!
    @IBOutlet weak var weaTitle4: UILabel!
    
    @IBOutlet weak var img5: UIImageView!
    @IBOutlet weak var temp5: UILabel!
    @IBOutlet weak var weaTitle5: UILabel!
    
    // Nav bar bottom
    
    // From segue
    var city : City?
    
    var weather5 : Any?
    
    var forecasts : [[String]] = []
    var imgs : [UIImage] = []
    
    var weatherClient = WeatherClient(key: "2888ec2cd2397d5e793783a09ed8cbc1")
    var favorisModel = FavorisModel.init()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelCity.text = city?.name

        let group = DispatchGroup()
        group.enter()
        
        weatherClient.forecast(for: city!, completion: { (forecastResult) in
            self.weather5 = forecastResult
            
            var day1 : [String] = [String(forecastResult?[0].temperature ?? 0.0),forecastResult?[0].weather[0].title ?? ""]
            var imgDay1 : UIImage = (forecastResult?[0].weather[0].icon ?? nil)!
            self.forecasts.append(day1)
            self.imgs.append(imgDay1)
            
            var day2 : [String] = [String(forecastResult?[8].temperature ?? 0.0),forecastResult?[8].weather[0].title ?? ""]
            var imgDay2 : UIImage = (forecastResult?[8].weather[0].icon ?? nil)!
            self.forecasts.append(day2)
            self.imgs.append(imgDay2)
            
            var day3 : [String] = [String(forecastResult?[16].temperature ?? 0.0),forecastResult?[16].weather[0].title ?? ""]
            var imgDay3 : UIImage = (forecastResult?[16].weather[0].icon ?? nil)!
            self.forecasts.append(day3)
            self.imgs.append(imgDay3)
            
            var day4 : [String] = [String(forecastResult?[24].temperature ?? 0.0),forecastResult?[24].weather[0].title ?? ""]
            var imgDay4 : UIImage = (forecastResult?[24].weather[0].icon ?? nil)!
            self.forecasts.append(day4)
            self.imgs.append(imgDay4)
            
            var day5 : [String] = [String(forecastResult?[32].temperature ?? 0.0),forecastResult?[32].weather[0].title ?? ""]
            var imgDay5 : UIImage = (forecastResult?[32].weather[0].icon ?? nil)!
            self.forecasts.append(day5)
            self.imgs.append(imgDay5)
       
            group.leave()
        } )
        group.wait()
        
        img1.image = imgs[0]
        temp1.text = "\(forecasts[0][0]) °C"
        weaTitle1.text = forecasts[0][1]
        
        img2.image = imgs[1]
        temp2.text = "\(forecasts[1][0]) °C"
        weaTitle2.text = forecasts[1][1]
        
        img3.image = imgs[2]
        temp3.text = "\(forecasts[2][0]) °C"
        weaTitle3.text = forecasts[2][1]
        
        img4.image = imgs[3]
        temp4.text = "\(forecasts[3][0]) °C"
        weaTitle4.text = forecasts[3][1]
        
        img5.image = imgs[4]
        temp5.text = "\(forecasts[4][0]) °C"
        weaTitle5.text = forecasts[4][1]
    }
    
    // MARK: - Navigation


}
