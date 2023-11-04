//
//  File.swift
//  Scatt Koala
//
//

import Foundation
import UIKit

extension UIViewController {
    func showActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        activityIndicator.color = UIColor.white
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            for subview in self.view.subviews {
                if let activityIndicator = subview as? UIActivityIndicatorView {
                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
                    self.view.isUserInteractionEnabled = true
                    break
                }
            }
        }
    }
}


