//
//  ArticlesTabViewController.swift
//  NYT-Articles
//
//  Created by 李祺 on 20/06/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import UIKit

class ArticlesTabViewController: UITabBarController, UITabBarControllerDelegate  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign self for delegate for that ViewController can respond to UITabBarControllerDelegate methods
        self.delegate = self
        self.navigationItem.title = "New York Times News"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create Tab one
        let emailedTab = ViewController(rankingFactor: .email)
        emailedTab.title = "Articles"
        let emailedTabBarItem = UITabBarItem(title: "emailed", image: UIImage(named: "icon-emailed.png"), selectedImage: UIImage(named: "icon-emailed.png"))
        
        emailedTab.tabBarItem = emailedTabBarItem
        
        
        let sharedTab = ViewController(rankingFactor: .share)
        sharedTab.title = "Articles"
        let sharedTabBarItem = UITabBarItem(title: "shared", image: UIImage(named: "icon-shared.png"), selectedImage: UIImage(named: "icon-shared.png"))
        
        sharedTab.tabBarItem = sharedTabBarItem
        
        let viewedTab = ViewController(rankingFactor: .view)
        viewedTab.title = "Articles"
        
        let viewedTabBarItem = UITabBarItem(title: "viewed", image: UIImage(named: "icon-viewed.png"), selectedImage: UIImage(named: "icon-viewed.png"))
        
        viewedTab.tabBarItem = viewedTabBarItem
        
        
        self.viewControllers = [emailedTab, sharedTab, viewedTab]
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}
