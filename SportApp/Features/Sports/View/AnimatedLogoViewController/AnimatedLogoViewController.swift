//
//  AnimatedLogoViewController.swift
//  SportApp
//
//  Created by Nafea Elkassas on 16/09/2025.
//

import UIKit

class AnimatedLogoViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    
    // MARK: - LifeCycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateLogo()
    }

    // MARK: - Animation
    private func animateLogo() {
        UIView.animate(withDuration: 1.0, animations: {
            // expand using transform (works best with constraints)
            self.logoImageView.transform = CGAffineTransform(scaleX: 6.0, y: 6.0)
        }, completion: { _ in
            UIView.animate(withDuration: 3, animations: {
                self.logoImageView.alpha = 0
            }, completion: { _ in
                self.goToHome()
            })
        })
    }
    
    // MARK: - Navigation
    private func goToHome() {
        let tabBar = MainTabBarController()
        navigationController?.setViewControllers([tabBar], animated: true)
    }



}
