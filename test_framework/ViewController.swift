//
//  ViewController.swift
//  test_framework
//
//  Created by m2sar on 10/05/2019.
//  Copyright © 2019 m2sar. All rights reserved.
//

import UIKit
import Weather

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    

    @IBOutlet weak var search_city: UISearchBar!
    @IBOutlet weak var table_suggestion_city: UITableView!
    
    var searchActive : Bool = false
    
    var searchTextValue : String!
    
    var searchSuggestionList : [City]!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
       // search_city.delegate = self;
       // table_suggestion_city.delegate = self;
       // table_suggestion_city.dataSource = self;
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
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
            searchSuggestionList = searchSuggestion.citiesSuggestions(for: searchTextValue);
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return searchSuggestionList.count
        }else {
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! UITableViewCell;
        if(searchActive){
            cell.textLabel?.text = searchSuggestionList[indexPath.row].name
        } else {
            cell.textLabel?.text = "";
        }
        
        return cell;
    }

}
