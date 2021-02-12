//
//  UIImage+Extensions.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 08.02.2021..
//

import UIKit

extension UIImage {
    var blurImage: UIImage? {
        if let ciImg = CIImage(image: self) {
            ciImg.applyingFilter("CIGaussianBlur")
            return UIImage(ciImage: ciImg)
        }
        return nil
    }
}
