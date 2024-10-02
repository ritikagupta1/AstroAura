//
//  SunSignCellCollectionViewCell.swift
//  HoroscopeApp
//
//  Created by Ritika Gupta on 25/09/24.
//

import UIKit

class SunSignCell: UICollectionViewCell {
    static let reuseIdentifier = Constants.sunSignCellIdentifier
    
    var imageView = UIImageView()
    var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        titleLabel.font = UIFont(name: Font.gothicMedium, size: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
       
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    func setUp(image: UIImage, title: String) {
        imageView.image = image
        titleLabel.text = title
    }
}
