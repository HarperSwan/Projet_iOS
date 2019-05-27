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
    
    @IBOutlet weak var btnUnwindToSearch: UIBarButtonItem!
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelTemperature: UILabel!
    
    @IBOutlet weak var imgTemps: UIImageView!
    @IBOutlet weak var labelWeaTitle: UILabel!
    @IBOutlet weak var labelWeaDescription: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnAddFavoris: UIButton!
    @IBOutlet weak var btnShowWeather5: UIButton!
    
    //let tabBarCnt = UITableViewController()
    //@IBOutlet weak var tabBar: UITabBar!
   // @IBOutlet weak var btnBarFavoris: UITabBarItem!
   // @IBOutlet weak var btnBarSearch: UITabBarItem!
    
    
    var weatherClient = WeatherClient(key: "2888ec2cd2397d5e793783a09ed8cbc1")
    var favorisModel = FavorisModel.init()
    var favorisAdded : Bool = false
    
    var city : City?
    var weatherNow : Any?
    var weather5 : Any?
    var fromSegue : String?

    var tempe : Float = 0.0
    var dateNow : Date = Date()
    var datas : [String:Float] = [:]
    var weaTitle : String = ""
    var weaDescription : String = ""
    var iconTemps : UIImage?
    
    var cellNames : [String] = []
    var cellLabels : [String] = ["Humidity","Clouds coverage","Temperature Min", "Wind speed","Temperature","Pressure","Temperature Max","Wind orientation"]
    var cellValues : [Float] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Update button favoris at first loading
        var idx = String(city?.identifier ?? 0)
        for city2 in favorisModel.listSaved {
            if (city2[0] == idx){
                favorisAdded = true
            }
        }

        let group = DispatchGroup()
        group.enter()
        
        weatherClient.weather(for: city!, completion: { (truc) in
            
            self.weatherNow = truc
            
            self.tempe = truc?.temperature ?? 0.0
            
            self.iconTemps = (truc?.weather[0].icon ?? nil)!
            
            self.dateNow = truc?.date ?? Date()
            
            self.datas["temperature"] = truc?.temperature ?? 0.0
            self.datas["temperatureMin"] = truc?.temperatureMin ?? 0.0
            self.datas["temperatureMax"] = truc?.temperatureMax ?? 0.0
            self.datas["pressure"] = truc?.pressure ?? 0.0
            self.datas["humidity"] = truc?.humidity ?? 0.0
            
            self.weaTitle = truc?.weather[0].title ?? ""
            self.weaDescription = truc?.weather[0].description ?? ""
            
            self.datas["cloudsCoverage"] = truc?.cloudsCoverage ?? 0.0
            self.datas["windSpeed"] = truc?.windSpeed ?? 0.0
            self.datas["windOrientation"] = truc?.windOrientation ?? 0.0

            
            group.leave()
        } )
        group.wait()
        
        imgTemps.image = iconTemps
        labelCity.text = city?.name
        labelTemperature.text = "\(tempe) °C"
        
        labelWeaTitle.text = weaTitle
        labelWeaDescription.text = weaDescription
        
        for (key,value) in datas{
            cellNames.append(key)
            cellValues.append(value)
        }
        
        // change button btnAddFavoris if favoris is added or not
        if (favorisAdded == true){
            btnAddFavoris.setTitle("Supprimer des favoris", for: [])
        }
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
        
        cell?.textLabel?.text = cellLabels[indexPath.row]
        cell?.detailTextLabel?.text = String(cellValues[indexPath.row])
        
        return cell!
    }
    
    // Button Add / Delete Favoris
    @IBAction func changeFavoris(_ sender: Any) {
        if (favorisAdded == true){ // Delete from favoris
            favorisModel.deleteFavoris(city: city!)
            favorisAdded = false
            btnAddFavoris.setTitle("Ajouter aux favoris", for: [])
        } else { // Add to favoris
            favorisModel.addFavoris(city: city!)
            favorisAdded = true
            btnAddFavoris.setTitle("Supprimer des favoris", for: [])
        }
    }
    
    // Button Previsions
    @IBAction func showPrevisions(_ sender: Any) {
        performSegue(withIdentifier: "segueWeather5", sender: self)
    }
    
    // Favoris button bar navigation
  /*  @IBAction func goToFavoris(_ sender: Any){
        performSegue(withIdentifier: "segueGoToFavorisFromWeatherNow", sender: self)
    }
    
    @IBAction func goToSearch(_ sender: Any){
        performSegue(withIdentifier: "segueGoToSearchFromWeatherNow", sender: self)
    }
    */
    // Segue Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueWeather5" {
            let VCDestination = segue.destination as! Weather5ViewController
            VCDestination.city = self.city
        } /*else if segue.identifier == "segueGoToFavorisFromWeatherNow" {
            let VCDestination = segue.destination as! FavorisViewController
        } else if segue.identifier == "segueGoToSearchFromWeatherNow"  {
            let VCDestination = segue.destination as! SearchViewController
        }*/
    }
    /*
    @IBAction func unwindtoFavoris(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
    }*/
/*
    func createTabBar(){
        tabBarCnt = UITabBarController()
        tabBarCnt.delegate = self
        tabBarCnt.tabBar.barStyle = .default

        let firstViewController = UIViewController()
        tabBarItem = UITabBarItem(title: "Favoris", image: UIImage(named: "favorite"), tag: 1)
        
    }*/
    /*
    func createTabBarController(){
        
        let favorisVC = FavorisViewController(coder: NSCoder())
        favorisVC?.title = "Favoris"
        favorisVC?.tabBarItem = btnBarFavoris
        
        let searchVC = SearchViewController(coder: NSCoder())
        searchVC?.title = "Recherche"
        searchVC?.tabBarItem = btnBarSearch
    }
    */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
