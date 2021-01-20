//
//  UITableView+Extensions.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 18.01.2021..
//

import UIKit

extension UITableView {
    func dequeue<T: UITableViewCell> (for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue reusable table view cell")
        }
        return cell
    }
}
