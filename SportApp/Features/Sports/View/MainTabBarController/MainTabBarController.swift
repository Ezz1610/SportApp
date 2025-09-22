import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .black
        setupTabs()
        setupTabColors()
    }
    
    private func setupTabs() {
        let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(title: "Stadium",
                                          image: UIImage(systemName: "sportscourt"),
                                          selectedImage: UIImage(systemName: "sportscourt.fill"))
        
        let favouritesVC = FavoritesViewController(nibName: "FavoritesViewController", bundle: nil)
        let favouritesNav = UINavigationController(rootViewController: favouritesVC)
        favouritesNav.tabBarItem = UITabBarItem(title: "Favorites",
                                                image: UIImage(systemName: "heart"),
                                                selectedImage: UIImage(systemName: "heart.fill"))
        
        let fexturesVC = FexturesViewController(nibName: "FexturesViewController", bundle: nil)
        let fexturesNav = UINavigationController(rootViewController: fexturesVC)
        fexturesNav.tabBarItem = UITabBarItem(title: "fex", image: UIImage(systemName: "person.fill"), tag: 2)
        
        viewControllers = [homeNav, favouritesNav, fexturesNav]
    }
    
    private func setupTabColors() {
        if let tabBarItems = tabBar.items {
            let darkGreen = UIColor(red: 0/255, green: 100/255, blue: 0/255, alpha: 1)
            let textColorNormal = UIColor.white
            let textColorSelected = UIColor.white
            
            // Apply to all tabs dynamically
            for item in tabBarItems {
                item.setTitleTextAttributes([.foregroundColor: textColorNormal], for: .normal)
                item.setTitleTextAttributes([.foregroundColor: textColorSelected], for: .selected)
            }
            
            // Icons with dark green
            tabBarItems[0].image = UIImage(systemName: "sportscourt")?.withTintColor(darkGreen, renderingMode: .alwaysOriginal)
            tabBarItems[0].selectedImage = UIImage(systemName: "sportscourt.fill")?.withTintColor(darkGreen, renderingMode: .alwaysOriginal)
            
            tabBarItems[1].image = UIImage(systemName: "heart")?.withTintColor(darkGreen, renderingMode: .alwaysOriginal)
            tabBarItems[1].selectedImage = UIImage(systemName: "heart.fill")?.withTintColor(darkGreen, renderingMode: .alwaysOriginal)
        }
    }
}
