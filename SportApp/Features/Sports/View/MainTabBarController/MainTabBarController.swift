import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
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
        
        viewControllers = [homeNav, favouritesNav]
    }
    
    private func setupTabColors() {
        guard let tabBarItems = tabBar.items else { return }

        let darkGreen = UIColor(red: 0/255, green: 100/255, blue: 0/255, alpha: 1)
        
        // Configure text attributes
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 12, weight: .regular)
        ]
        
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 12, weight: .bold)
        ]
        
        // Apply globally using UITabBarAppearance (iOS 13+)
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
//         tabBar.layer.shadowColor = UIColor.black.cgColor
//         tabBar.layer.shadowOpacity = 0.1
//         tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
//         tabBar.layer.shadowRadius = 4
        
        // Custom icons tint (dark green)
        tabBarItems[0].image = UIImage(systemName: "sportscourt")?.withTintColor(darkGreen, renderingMode: .alwaysOriginal)
        tabBarItems[0].selectedImage = UIImage(systemName: "sportscourt.fill")?.withTintColor(darkGreen, renderingMode: .alwaysOriginal)
        
        tabBarItems[1].image = UIImage(systemName: "heart")?.withTintColor(darkGreen, renderingMode: .alwaysOriginal)
        tabBarItems[1].selectedImage = UIImage(systemName: "heart.fill")?.withTintColor(darkGreen, renderingMode: .alwaysOriginal)
    }}
