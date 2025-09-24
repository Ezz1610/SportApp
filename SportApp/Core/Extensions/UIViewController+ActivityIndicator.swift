//
//  UIViewController+ActivityIndicator.swift
//  SportApp
//
//  Created by Nafea Elkassas on 25/09/2025.
//

import NVActivityIndicatorView
import UIKit
extension UIViewController {
    
    private struct Holder {
        static var loader: NVActivityIndicatorView?
    }
    
    func showLoader() {
        if Holder.loader == nil {
            let size: CGFloat = 60
            let loaderFrame = CGRect(
                x: (view.frame.width - size) / 2,
                y: (view.frame.height - size) / 2,
                width: size,
                height: size
            )
            
            let loader = NVActivityIndicatorView(
                frame: loaderFrame,
                type: .orbit,
                color: .black,
                padding: 0
            )
            
            view.addSubview(loader)
            Holder.loader = loader
        }
        
        Holder.loader?.startAnimating()
        Holder.loader?.isHidden = false
    }
    
    func hideLoader() {
        Holder.loader?.stopAnimating()
        Holder.loader?.removeFromSuperview()
        Holder.loader = nil
    }
}
