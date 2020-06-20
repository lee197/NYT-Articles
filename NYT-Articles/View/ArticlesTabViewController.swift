//
//  ArticlesTabViewController.swift
//  NYT-Articles
//
//  Created by 李祺 on 20/06/2020.
//  Copyright © 2020 Lee. All rights reserved.
//

import UIKit

class ArticlesTabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "New York Times News"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let emailedTab = ArticleListViewController(rankingFactor: .email)
        let emailedTabBarItem = UITabBarItem(title: "emailed", image: UIImage(named: "icon-emailed.png"), selectedImage: UIImage(named: "icon-emailed.png"))
        emailedTab.tabBarItem = emailedTabBarItem
        
        let sharedTab = ArticleListViewController(rankingFactor: .share)
        let sharedTabBarItem = UITabBarItem(title: "shared", image: UIImage(named: "icon-shared.png"), selectedImage: UIImage(named: "icon-shared.png"))
        sharedTab.tabBarItem = sharedTabBarItem
        
        let viewedTab = ArticleListViewController(rankingFactor: .view)
        let viewedTabBarItem = UITabBarItem(title: "viewed", image: UIImage(named: "icon-viewed.png"), selectedImage: UIImage(named: "icon-viewed.png"))
        viewedTab.tabBarItem = viewedTabBarItem
        
        self.viewControllers = [emailedTab, sharedTab, viewedTab]
    }
}
