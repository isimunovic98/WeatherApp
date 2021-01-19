//
//  UIStackView+Extension.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 19.01.2021..
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ subviews: [UIView]) {
        for view in subviews {
            self.addArrangedSubview(view)
        }
    }
}
