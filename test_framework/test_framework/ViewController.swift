//
//  ViewController.swift
//  test_framework
//
//  Created by m2sar on 10/05/2019.
//  Copyright © 2019 m2sar. All rights reserved.
//

import UIKit
import Weather

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var search_city: UISearchBar!
    
    var searchActive : Bool = false
    
    var searchTextValue : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        search_city.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        //search_city.sendActionsForControlEvents
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("nop !");
        searchBar.text = "";
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(!searchText.isEmpty) {
            searchTextValue = searchText;
            //let searchSuggestion = WeatherClient(key: searchText);
            //print(searchSuggestion.citiesSuggestions(for: searchText))
        }
        searchActive = true;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if(searchTextValue != nil) {
            let searchSuggestion = WeatherClient(key: searchTextValue);
            print(searchSuggestion.citiesSuggestions(for: searchTextValue))
        }
    }

}

