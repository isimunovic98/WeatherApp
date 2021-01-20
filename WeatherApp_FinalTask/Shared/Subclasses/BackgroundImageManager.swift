//
//  BackgroundImageManager.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 19.01.2021..
//

import UIKit

class BackgroundImageManager {
    static func getBackgroundImage(for weatherId: Int,and dayNightIndicator: String) -> UIImage {
        let indicator = dayNightIndicator.suffix(1)
        switch weatherId {
        case 200..<233:
            return UIImage(named: "body_image-thunderstorm")!
        case 300..<532:
            return UIImage(named: "body_image-rain")!
        case 611..<613:
            return UIImage(named: "body_image-sleet")!
        case 600..<623:
            return UIImage(named: "body_image-snow")!
        case 741:
            return UIImage(named: "body_image-fog")!
        case 781:
            return UIImage(named: "body_image-tornado")!
        case 800:
            if indicator == "d" {
                return UIImage(named: "body_image-clear-day")!
            } else {
                return UIImage(named: "body_image-clear-night")!
            }
        default:
            if indicator == "d" {
                return UIImage(named: "body_image-partly-cloudy-day")!
            } else {
                return UIImage(named: "body_image-partly-cloudy-night")!
            }
        }
    }
}
