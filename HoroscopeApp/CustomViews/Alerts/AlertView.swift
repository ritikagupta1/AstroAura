//
//  AlertView.swift
//  HoroscopeApp
//
//  Created by Ritika Gupta on 03/10/24.
//

import UIKit

class AlertView: UIView {
    let alertTitleLabel = TitleLabel(font: UIFont(name: Font.typeWriterBold, size: 24), alignment: .center, numberOfLines: 1)
    let alertMessageLabel = TitleLabel(font: UIFont(name: Font.gothicMedium, size: 16), alignment: .center, numberOfLines: 2)
    let button: UIButton = UIButton()
    var buttonAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(alertTitle: String, alertMessage: String, buttonTitle: String, buttonAction: @escaping () -> Void) {
        super.init(frame: .zero)
        
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 16
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1.0
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.alertTitleLabel.text = alertTitle
        self.addSubview(alertTitleLabel)
        
        self.alertMessageLabel.text = alertMessage
        self.addSubview(alertMessageLabel)
        
        self.button.layer.cornerRadius = 8
        self.button.titleLabel?.font = UIFont(name: Font.typeWriterBold, size: 20)
        self.button.setTitleColor(.white, for: .normal)
        self.button.setTitle(buttonTitle, for: .normal)
        self.button.backgroundColor = .button
        self.button.translatesAutoresizingMaskIntoConstraints = false
        self.button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        self.buttonAction = buttonAction
        
        
        self.addSubview(button)
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            alertTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            alertTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            alertTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            alertTitleLabel.heightAnchor.constraint(equalToConstant: 26),
            
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 44),
            
            alertMessageLabel.topAnchor.constraint(equalTo: alertTitleLabel.bottomAnchor, constant: padding),
            alertMessageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            alertMessageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            alertMessageLabel.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -padding)
        ])
    }
    
    @objc func buttonClicked() {
        buttonAction?()
    }
}
