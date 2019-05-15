//
//  FavorisModel.swift
//  test_framework
//
//  Created by Viviane on 15/05/2019.
//  Copyright © 2019 m2sar. All rights reserved.
//

import Foundation

class FavorisModel {
    
    var listFavorisSaved : [String]
    
    init() {
        listFavorisSaved = [""]
    }
    
    func loadFavoris(){
        
    }
    
    func saveFavoris(cities: [String]){

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
    
}
