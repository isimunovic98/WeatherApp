//
//  UIViewController+Extensions.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 17.01.2021..
//

import UIKit

extension UIViewController {
    func showBlurView() {
        BlurViewManager.addBlurView(to: self.view)
    }
    
    func removeBlurView() {
        BlurViewManager.removeBlurView()
    }
    
    func presentAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: false, completion: nil)
    }
}
