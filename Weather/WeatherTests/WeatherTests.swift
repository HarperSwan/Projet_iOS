//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Adrien Humiliere on 06/05/2019.
//  Copyright © 2019 adhumi. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherTests: XCTestCase {
    var wc : WeatherClient!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        wc = WeatherClient(key : "2888ec2cd2397d5e793783a09ed8cbc1");
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //print(wc.citiesSuggestions(for : "pari"));
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}



