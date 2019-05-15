//
//  FavorisModel.swift
//  test_framework
//
//  Created by Viviane on 15/05/2019.
//  Copyright © 2019 m2sar. All rights reserved.
//

import Foundation
import Weather

class FavorisModel {
    
    let defaults = UserDefaults.standard
    var listSaved : [City]
    var listFavorisSaved : [City]
    
    init() {
        listFavorisSaved = []
        listSaved = defaults.array(forKey: "favoris") as! [City]
    }
    
    func loadFavoris(){
        listSaved = defaults.array(forKey: "favoris") as! [City]
    }
    
    func saveFavoris(city: City){

        /*
        let weatherClient = WeatherClient(key: "2888ec2cd2397d5e793783a09ed8cbc1")
        lists = weatherClient.citiesSuggestions(for: "Paris")
        
        //var city1 : City = City(name: "London")
        /*city1.name = "London"
         city1.country = "GB"
         city1.identifier = 5091*/
        //var city = weatherClient.weather(for city: city1)
        //var city = weatherClient.weather(for: city1, completion: @escaping ()-> Void)
        var city = weatherClient.weather(for: lists[1], completion: @escaping ()-> Void)
        print(city)
        */
        
        
    }
    
    // Add a City from Favoris
    func addFavoris(city: City){
        // intialise temporary variables
        listFavorisSaved.removeAll()
        loadFavoris()
        
        // add to temporary list
        var list2 = listFavorisSaved.append(city)
        
        // actualize
        defaults.set(list2,forKey: "favoris")
        defaults.synchronize()
    }
    
    
    // Delete a City from Favoris
    func deleteFavoris(city: City){
        // intialise temporary variables
        listFavorisSaved.removeAll()
        loadFavoris()
        
        var list2 : [City] = []
        
        // supprimer Favoris de la liste
        for city2 in listSaved{
            if city2.identifier != city.identifier{
                list2.append(city2)
            }
        }
        
        // actualize
        defaults.set(list2,forKey: "favoris")
        defaults.synchronize()
    }
    
}
