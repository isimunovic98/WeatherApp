//
//  WeatherConditionsView.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 14.01.2021..
//

import UIKit
import SnapKit

class WeatherConditionView: UIView {

    //MARK: Properties
    let conditionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let conditionValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = label.font.withSize(15)
        return label
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
      super.init(frame: frame)
      setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
    }

}

// - MARK: UI Setup
private extension WeatherConditionView {
    func setupView() {
        let views = [conditionImageView, conditionValueLabel]
        self.addSubviews(views)
        setupLayout()

    }
    
    func setupLayout() {
        conditionImageView.snp.makeConstraints { (make) in
            make.top.bottom.centerX.equalTo(self)
            make.size.equalTo(50)
        }
        
        conditionValueLabel.snp.makeConstraints { (make) in
            make.top.equalTo(conditionImageView.snp.bottom).offset(5)
            make.centerX.leading.trailing.equalTo(self)
        }
    }
}
