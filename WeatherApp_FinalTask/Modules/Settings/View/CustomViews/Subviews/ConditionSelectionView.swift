//
//  CondtitionSelectionView.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 18.01.2021..
//

import UIKit
import SnapKit
import DLRadioButton

class ConditionSelectionView: UIView {
    //MARK: Properties
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    let conditionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let conditionSelectionButton: DLRadioButton = {
        let radioButton = DLRadioButton()
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        return radioButton
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

//MARK: - UI
private extension ConditionSelectionView {
    func setupView() {
        addSubview(stackView)
        stackView.addArrangedSubview(conditionImageView)
        stackView.addArrangedSubview(conditionSelectionButton)
        setupConstraints()
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
}



