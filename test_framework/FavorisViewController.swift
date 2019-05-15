//
//  FavorisViewController.swift
//  test_framework
//
//  Created by Viviane on 13/05/2019.
//  Copyright © 2019 m2sar. All rights reserved.
//

import UIKit

struct FavorisItem {
    var city : String
    var temp : String
    var image : String
}

class FavorisViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tbFavoris: UITableView!
    
    let cellReuseIdentifier = "cellFavoris"
    
    var favorisLists : [FavorisItem] = [
        FavorisItem(city: "Paris", temp: "26 °C", image: "search"),
        FavorisItem(city: "New York", temp: "29 °C", image: "search"),
    ]
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Favoris", image: UIImage(named: "favorite"), tag: 1) // tab bar
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Table of favoris // number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(favorisLists.count)
        return favorisLists.count
    }
    
    // Table of favoris // number of section
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    // Table of favoris // content
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellFavoris = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for:indexPath) as! FavorisTableViewCell
        
        let favoris = favorisLists[indexPath.row]
        cellFavoris.ville?.text = favoris.city
        cellFavoris.temp?.text = favoris.temp
        cellFavoris.img?.image = UIImage(named: favoris.image)
        
        return cellFavoris
    }
    
    // TableView // Height of a row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83.0
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
