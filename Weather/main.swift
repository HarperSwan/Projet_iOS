//
//  main.swift
//  Weather
//
//  Created by m2sar on 07/05/2019.
//  Copyright © 2019 adhumi. All rights reserved.
//

import Foundation


let wc : WeatherClient = WeatherClient(key : "2888ec2cd2397d5e793783a09ed8cbc1");

let result = wc.citiesSuggestions(for: "pari")

print(result)
