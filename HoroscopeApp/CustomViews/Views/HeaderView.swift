//
//  HeaderView.swift
//  HoroscopeApp
//
//  Created by Ritika Gupta on 07/10/24.
//

import UIKit
class HeaderView: UIView {
    var imageView =  UIImageView()
    var label = TitleLabel(font: UIFont(name: Font.baskerVilleBoldItalic, size: 40), alignment: .center, numberOfLines: 1, textcolor: .white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 280),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -60),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func setup(with sign: Sign) {
        self.imageView.image = sign.image
        self.label.text = sign.rawValue
    }
}
