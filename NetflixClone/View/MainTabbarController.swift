//
//  MainTabbarController.swift
//  NetflixClone
//
//  Created by Bayram Yeleç on 28.12.2024.
//

import UIKit

class MainTabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let vc1 = HomeVC()
        let vc2 = UINavigationController(rootViewController: NewVC())
        let vc3 = UINavigationController(rootViewController: SearchVC())
        let vc4 = UINavigationController(rootViewController: DownloadVC())
        
        vc1.tabBarItem.image = UIImage(systemName: "house.fill")
        vc2.tabBarItem.image = UIImage(systemName: "play.square.stack.fill")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc4.tabBarItem.image = UIImage(systemName: "arrow.down.circle")
        
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .systemGray2
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .black
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
        
        setViewControllers([vc1, vc3, vc2, vc4], animated: true)
    }
    
}
