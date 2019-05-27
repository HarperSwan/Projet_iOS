//
//  FavorisViewController.swift
//  test_framework
//
//  Created by Viviane on 13/05/2019.
//  Copyright © 2019 m2sar. All rights reserved.
//

import UIKit
import Weather

struct FavorisItem {
    var city : String
    var temp : String
    var image : String
}

class FavorisViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    // Table
    @IBOutlet weak var tbFavoris: UITableView!
    let cellReuseIdentifier = "cellFavoris" // table cell name
    var favorisLists : [FavorisItem] = [
        FavorisItem(city: "Paris", temp: "26 °C", image: "search"),
        FavorisItem(city: "New York", temp: "29 °C", image: "search"),
    ]
    var refreshControl: UIRefreshControl?
    
    var weatherClient = WeatherClient(key: "2888ec2cd2397d5e793783a09ed8cbc1")
    var favorisModel = FavorisModel.init()
    
    var citiesFavoris : [City] = []
    
    // Segue variables
    var activeCity : City?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Favoris", image: UIImage(named: "favorite"), tag: 1) // tab bar
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCities()
        addRefreshControl()
    }
    
    // Table of favoris // number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesFavoris.count
    }
    
    // Table of favoris // number of section
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    // Table of favoris // content
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellFavoris = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for:indexPath) as! FavorisTableViewCell
        /*
        let favoris = favorisLists[indexPath.row]
        cellFavoris.ville?.text = favoris.city
        cellFavoris.temp?.text = favoris.temp
        cellFavoris.img?.image = UIImage(named: favoris.image)*/
        
        let favoris = citiesFavoris[indexPath.row]
        cellFavoris.ville?.text = favoris.name
        
        var tempe : Float?
        var iconTemps : UIImage?
        var weaTitle : String?
        
        let group = DispatchGroup()
        group.enter()
        weatherClient.weather(for: citiesFavoris[indexPath.row], completion: { (forec) in
            
            tempe = forec?.temperature ?? 0.0

            iconTemps = (forec?.weather[0].icon ?? nil)!
            weaTitle = forec?.weather[0].title ?? ""
            
            group.leave()
        } )
        group.wait()
        
        cellFavoris.temp?.text = "\(tempe ?? 0.0) °C | \(weaTitle ?? "") "
        cellFavoris.img?.image = iconTemps
        
        return cellFavoris
    }
    
    // TableView // Height of a row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83.0
    }
    
    // Add refresh to the view
    func addRefreshControl(){
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        tbFavoris.addSubview(refreshControl!)
    }
    
    // Refresh when pull tableview
    @objc func refreshList(){
        loadCities()
        tbFavoris.reloadData()
        refreshControl?.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var idx = indexPath.row
        activeCity = citiesFavoris[idx]
        
        performSegue(withIdentifier: "segueWeatherCityFromFav", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueWeatherCityFromFav" {
            let VCDestination = segue.destination as! WeatherViewController
            VCDestination.city = self.activeCity
            VCDestination.fromSegue = "Favoris"
        }
    }
    
    func loadCities(){
        citiesFavoris.removeAll()
        favorisModel.loadFavoris()
        let citiesSaved = favorisModel.listSaved
        
        for cityS in citiesSaved {
            var cities = weatherClient.citiesSuggestions(for: cityS[1])
            for city in cities {
                if (String(city.identifier) == cityS[0]){
                    citiesFavoris.append(city)
                }
            }
        }
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
