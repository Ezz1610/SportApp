//
//  UIImageView+DownloadImageFromUrl.swift
//  SportApp
//
//  Created by Nafea Elkassas on 23/09/2025.
//

import Foundation
import UIKit
extension UIImageView {
    func loadImage(from urlString: String?, placeholder: UIImage? = UIImage(named: "unknownLeague")) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            self.image = placeholder
            return
        }
        
        self.image = placeholder
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil,
                  let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
