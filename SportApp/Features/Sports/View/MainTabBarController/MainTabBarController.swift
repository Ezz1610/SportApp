//
//  MainTabBarController.swift
//  SportApp
//
//  Created by Nafea Elkassas on 16/09/2025.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
            super.viewDidLoad()
        self.tabBar.backgroundColor = .green
            setupTabs()
        }
        
        private func setupTabs() {
            let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
            let homeNav = UINavigationController(rootViewController: homeVC)
            homeNav.tabBarItem = UITabBarItem(title: "Home",
                                              image: UIImage(systemName: "house"),
                                              selectedImage: UIImage(systemName: "house.fill"))
            
            let favouritesVC = FavoritesViewController(nibName: "FavoritesViewController", bundle: nil)
            favouritesVC.title = "Favorites"
            let favouritesNav = UINavigationController(rootViewController: favouritesVC)
            favouritesNav.tabBarItem = UITabBarItem(title: "Favorites",
                                                    image: UIImage(systemName: "star"),
                                                    selectedImage: UIImage(systemName: "star.fill"))
            
            viewControllers = [homeNav, favouritesNav]
        }


}
