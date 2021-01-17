//
//  UIViewController+Extensions.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 17.01.2021..
//

import UIKit

extension UIViewController {
    func showBlurLoader() {
        BlurViewManager.addBlurView(to: self.view)
    }
    
    func removeBlurLoader() {
        BlurViewManager.removeBlurView()
    }
}
