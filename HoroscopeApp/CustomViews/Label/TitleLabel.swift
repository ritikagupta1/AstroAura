//
//  TitleLabel.swift
//  HoroscopeApp
//
//  Created by Ritika Gupta on 03/10/24.
//

import UIKit

class TitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(
        font: UIFont?,
        alignment: NSTextAlignment = .left,
        numberOfLines: Int = 1,
        textcolor: UIColor = .label) {
        self.init(frame: .zero)
        self.textAlignment = alignment
        self.font = font ?? UIFont.systemFont(ofSize: 18)
        self.numberOfLines = numberOfLines
        self.textColor = textcolor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.lineBreakMode = .byTruncatingTail
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.9
    }
}
