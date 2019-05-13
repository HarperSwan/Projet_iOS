//
//  FavorisViewController.swift
//  test_framework
//
//  Created by Viviane on 13/05/2019.
//  Copyright © 2019 m2sar. All rights reserved.
//

import UIKit

class FavorisViewController: UIViewController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Favoris", image: UIImage(named: "favorite"), tag: 1)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
