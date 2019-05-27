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
    
    var listSaved : [[String]] = [] // list saved in the memory
    var listFavorisSaved : [[String]] = [] // temporary list for functions
    
    init() {
        listFavorisSaved = []
        
        if (defaults.array(forKey: "favoris") != nil){
            listSaved = defaults.array(forKey: "favoris") as! [[String]]
        } else {
            listSaved = []
        }
        //print(defaults.array(forKey: "favoris"))
    }
    
    func loadFavoris(){
        if (defaults.array(forKey: "favoris") != nil){
            listSaved = defaults.array(forKey: "favoris") as! [[String]]
        } else {
            listSaved = []
        }
        //print("LOAD : \(defaults.array(forKey: "favoris"))")
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
        listFavorisSaved = listSaved
        var ajout : [String] = [String(city.identifier),city.name,city.country]
        
        listFavorisSaved.append(ajout)
        
        // actualize
        defaults.set(listFavorisSaved,forKey: "favoris")
        defaults.synchronize()
        loadFavoris()
    }
    
    
    // Delete a City from Favoris
    func deleteFavoris(city: City){
        // intialise temporary variables
        listFavorisSaved.removeAll()
        loadFavoris()
        
        var list2 : [[String]] = []
        
        // supprimer Favoris de la liste
        for city2 in listSaved {
            if city2[0] != String(city.identifier){
                list2.append(city2)
            }
        }
        
        // actualize
        if (list2 == []) {
            defaults.removeObject(forKey: "favoris")
        } else {
            defaults.set(list2,forKey: "favoris")
        }
        defaults.synchronize()
        loadFavoris()
    }
    
}
