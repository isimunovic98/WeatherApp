//
//  UIView+Extensions.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 12.01.2021..
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: [UIView]) {
        for subview in subviews {
            addSubview(subview)
        }
    }
    
    func takeScreenshot() -> UIImage {
            // Begin context
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)

            // Draw view in that context
            drawHierarchy(in: self.bounds, afterScreenUpdates: true)

            // And finally, get image
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            if (image != nil)
            {
                return image!
            }
            return UIImage()
        }
}
