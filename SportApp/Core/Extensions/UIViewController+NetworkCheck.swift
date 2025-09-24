//
//  UIViewController+NetworkCheck.swift
//  SportApp
//
//  Created by Nafea Elkassas on 25/09/2025.
//

import Foundation
import UIKit
extension UIViewController {
    func checkInternetOrShowAlert() -> Bool {
        if !NetworkMonitor.shared.isConnected {
            let alert = UIAlertController(
                title: "No Internet Connection",
                message: "Please connect to the internet to continue.",
                preferredStyle: .alert
            )
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                if let nav = self.navigationController {

                    let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
                    nav.setViewControllers([homeVC], animated: true)
                }
            }
            alert.addAction(okAction)
            present(alert, animated: true)
            return false
        }
        return true
    }
}
