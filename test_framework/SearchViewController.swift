//
//  SearchViewController.swift
//  test_framework
//
//  Created by Viviane on 13/05/2019.
//  Copyright © 2019 m2sar. All rights reserved.
//
//  _ Controller for the search view
//
//  > Search by a city
//  > Display a list of cities and their country
//

import UIKit
import Weather

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    // Declaration of search bar
    @IBOutlet weak var searchBar: UISearchBar!
    // Declaration of table of cities
    @IBOutlet weak var tbCities: UITableView!
    
    //var weatherClient : WeatherClient
    var citiesList : [City]! // List when search is empty
    var weatherClient = WeatherClient(key: "2888ec2cd2397d5e793783a09ed8cbc1")
    
    // informations of the search
    var searchedCity = [String]() // List when search is done
    var searchedCityID = [Int64]() // list of IDs
    var searchedCityCountry = [String]() // list of country
    var searchTextValue : String!
    var searching = false

    
    // Initialisation
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Tab Bar
        tabBarItem = UITabBarItem(title: "Recherche", image: UIImage(named: "search"), tag: 2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        // allow to hide keyboard when tapping
        hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
    }
    
    // Table // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedCity.count
        } else {
            return 1
        }
    }

    
    // Table // search update // reload
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = tableView.dequeueReusableCell(withIdentifier: "city")
        if searching { // display the searched results
            city?.textLabel?.text = searchedCity[indexPath.row]
            city?.detailTextLabel?.text = searchedCityCountry[indexPath.row]
        } else { // When search is empty
            city?.textLabel?.text = ""
            city?.detailTextLabel?.text = ""
        }
        return city!
    }
    
    // search done at every tapping // too long
    /*
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCitiesList(textSearch: searchText)
        print(citiesList)
        for cityL in citiesList {
            searchedCity.append(cityL.name)
        }
       // searchedCity = citiesList.filter({_ in City["name"].lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tbCities.reloadData()
    }
 */
    
    // search done when button clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // clean datas
        searchedCity.removeAll()
        searchedCityID.removeAll()
        searchedCityCountry.removeAll()
        
        // search from the text entered
        searchCitiesList(textSearch: searchBar.text!)
        
        // prepare for table view
        for cityL in citiesList {
            searchedCity.append(cityL.name)
            searchedCityID.append(cityL.identifier)
            searchedCityCountry.append(cityL.country)
        }
        // searchedCity = citiesList.filter({_ in City["name"].lowercased().prefix(searchText.count) == searchText.lowercased()})
        
        searching = true
        tbCities.reloadData() // reload the tableview
    }
    
    // When search is cancelled
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tbCities.reloadData()
    }
    
    // Cities search with framework
    func searchCitiesList(textSearch: String){
        citiesList = nil
        if (textSearch != ""){
            citiesList = weatherClient.citiesSuggestions(for: textSearch)
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
// hide keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
