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
}
