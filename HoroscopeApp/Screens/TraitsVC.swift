//
//  TraitsVC.swift
//  HoroscopeApp
//
//  Created by Ritika Gupta on 07/10/24.
//

import UIKit

class TraitsVC: ScrollableVC {
    
    var dateLabel = TitleLabel(font: UIFont(name: Font.baskerVilleBoldItalic, size: 26), alignment: .center)
    
    var rulingPlanetLabel = TitleLabel(font: UIFont(name: Font.typeWriterBold, size: 26))
    var rulingPlanetValue = TitleLabel(font: UIFont(name: Font.typeWriter, size: 22))
    
    var elementLabel = TitleLabel(font: UIFont(name: Font.typeWriterBold, size: 26))
    var elementValue = TitleLabel(font: UIFont(name: Font.typeWriter, size: 22))
    
    var luckyNumberLabel = TitleLabel(font: UIFont(name: Font.typeWriterBold, size: 26))
    var luckyNumberValue = TitleLabel(font: UIFont(name: Font.typeWriter, size: 22))
    
    var luckyColorLabel = TitleLabel(font: UIFont(name: Font.typeWriterBold, size: 26))
    var luckyColorValue = TitleLabel(font: UIFont(name: Font.typeWriter, size: 22))
    
    var strengthLabel = UILabel()
    var weaknessLabel = UILabel()
    
    var compatibleSignLabel = TitleLabel(font: UIFont(name: Font.typeWriterBold, size: 28) )
    
    var compatibilityStackView = UIStackView()
    
    var personalityTraitLabel = TitleLabel(font: UIFont(name: Font.typeWriterBold, size: 28) )
    var personalityTraitValue = TitleLabel(font: UIFont(name: Font.typeWriter, size: 22))
    
    var selectedSign: Sign?
    var traits: Traits?
    
    init(selectedSign: Sign) {
        self.selectedSign = selectedSign
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        getTraits()
    }
    
    private func configure() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(rulingPlanetLabel)
        contentView.addSubview(rulingPlanetValue)
        contentView.addSubview(elementLabel)
        contentView.addSubview(elementValue)
        contentView.addSubview(luckyNumberLabel)
        contentView.addSubview(luckyColorLabel)
        contentView.addSubview(luckyNumberValue)
        contentView.addSubview(luckyColorValue)

        strengthLabel.numberOfLines = 0
        strengthLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(strengthLabel)
        
        weaknessLabel.numberOfLines = 0
        weaknessLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(weaknessLabel)
        
        contentView.addSubview(compatibleSignLabel)
        
        compatibilityStackView.axis = .vertical
        compatibilityStackView.spacing = 10
        compatibilityStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(compatibilityStackView)
        
        contentView.addSubview(personalityTraitLabel)
        contentView.addSubview(personalityTraitValue)
    
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            dateLabel.heightAnchor.constraint(equalToConstant: 28),
           
            rulingPlanetLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            rulingPlanetLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            rulingPlanetLabel.widthAnchor.constraint(equalToConstant: 180),
            rulingPlanetLabel.heightAnchor.constraint(equalToConstant: 28),
            
            rulingPlanetValue.centerYAnchor.constraint(equalTo: rulingPlanetLabel.centerYAnchor),
            rulingPlanetValue.leadingAnchor.constraint(equalTo: rulingPlanetLabel.trailingAnchor, constant: 8),
            rulingPlanetValue.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            rulingPlanetValue.heightAnchor.constraint(equalToConstant: 24),
            
            elementLabel.topAnchor.constraint(equalTo: rulingPlanetLabel.bottomAnchor, constant: 12),
            elementLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            elementLabel.widthAnchor.constraint(equalToConstant: 120),
            elementLabel.heightAnchor.constraint(equalToConstant: 28),
            
            elementValue.centerYAnchor.constraint(equalTo: elementLabel.centerYAnchor),
            elementValue.leadingAnchor.constraint(equalTo: elementLabel.trailingAnchor, constant: 8),
            elementValue.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            elementValue.heightAnchor.constraint(equalToConstant: 24),
            
            luckyNumberLabel.topAnchor.constraint(equalTo: elementLabel.bottomAnchor, constant: 12),
            luckyNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            luckyNumberLabel.widthAnchor.constraint(equalToConstant: 200),
            luckyNumberLabel.heightAnchor.constraint(equalToConstant: 28),
            
            luckyNumberValue.centerYAnchor.constraint(equalTo: luckyNumberLabel.centerYAnchor),
            luckyNumberValue.leadingAnchor.constraint(equalTo: luckyNumberLabel.trailingAnchor, constant: 8),
            luckyNumberValue.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            luckyNumberValue.heightAnchor.constraint(equalToConstant: 24),
            
            luckyColorLabel.topAnchor.constraint(equalTo: luckyNumberLabel.bottomAnchor, constant: 12),
            luckyColorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            luckyColorLabel.widthAnchor.constraint(equalToConstant: 180),
            luckyColorLabel.heightAnchor.constraint(equalToConstant: 28),
            
            luckyColorValue.centerYAnchor.constraint(equalTo: luckyColorLabel.centerYAnchor),
            luckyColorValue.leadingAnchor.constraint(equalTo: luckyColorLabel.trailingAnchor, constant: 8),
            luckyColorValue.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            luckyColorValue.heightAnchor.constraint(equalToConstant: 24),
            
            
            strengthLabel.topAnchor.constraint(equalTo: luckyColorLabel.bottomAnchor, constant: 12),
            strengthLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            strengthLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            weaknessLabel.topAnchor.constraint(equalTo: strengthLabel.bottomAnchor),
            weaknessLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            weaknessLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            compatibleSignLabel.topAnchor.constraint(equalTo: weaknessLabel.bottomAnchor),
            compatibleSignLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            compatibleSignLabel.widthAnchor.constraint(equalToConstant: 250),
            compatibleSignLabel.heightAnchor.constraint(equalToConstant: 30),
            
            compatibilityStackView.topAnchor.constraint(equalTo: compatibleSignLabel.bottomAnchor, constant: 10),
            compatibilityStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            compatibilityStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            personalityTraitLabel.topAnchor.constraint(equalTo: compatibilityStackView.bottomAnchor, constant: 10),
            personalityTraitLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            personalityTraitLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            personalityTraitLabel.heightAnchor.constraint(equalToConstant: 28),
            
            personalityTraitValue.topAnchor.constraint(equalTo: personalityTraitLabel.bottomAnchor, constant: 10),
            personalityTraitValue.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            personalityTraitValue.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            personalityTraitValue.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    
    private func getTraits() {
        guard let selectedSign = selectedSign else {
            return
        }
        self.showLoadingView()
        NetworkManager.shared.getTraits(sign: selectedSign) { result in
            self.dismissLoadingView()
            switch result {
            case .success(let traits):
                DispatchQueue.main.async {
                    self.traits = traits
                    self.setupTraits(traits: traits)
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presentAlertViewController(
                        title: Constants.somethingWentWrong,
                        message: error.rawValue,
                        buttonTitle: Constants.ok) {}
                }
            }
        }
    }
    
    func setupTraits(traits: Traits) {
        dateLabel.text = "\(traits.startDate) - \(traits.endDate)"
        rulingPlanetLabel.text = Constants.rulingPlanet
        rulingPlanetValue.text = traits.rulingPlanet
        elementLabel.text =  Constants.element
        elementValue.text = traits.element
        luckyNumberLabel.text = Constants.luckyNumber
        luckyNumberValue.text = traits.luckyNumber.description
        luckyColorLabel.text = Constants.luckyColor
        luckyColorValue.text = traits.luckyColor
        let strengths =  traits.strengths
        let weakness =  traits.weaknesses
        let compatibleSigns: [Sign] = traits.compatibleSigns.compactMap { Sign(rawValue: $0) }
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: Font.typeWriterBold, size: 26) ?? .systemFont(ofSize: 22)]
        let strengthTitleText = NSAttributedString(string: Constants.strength, attributes: attributes)
        let strengthText = NSMutableAttributedString()
        strengthText.append(strengthTitleText)
        strengthText.append(createBulletPointString(items: strengths))
        
        strengthLabel.attributedText = strengthText
        
        
        let weaknessTitleText = NSAttributedString(string: Constants.weaknesses, attributes: attributes)
        let weaknessText = NSMutableAttributedString()
        weaknessText.append(weaknessTitleText)
        weaknessText.append(createBulletPointString(items: weakness))
        
        weaknessLabel.attributedText = weaknessText
        
        compatibleSignLabel.text = Constants.compatibleSigns
        
        let numberofRows = Int(ceil(Double(compatibleSigns.count)/3.0))
        let padding: CGFloat = 10.0
        let stackViewPadding: CGFloat = 10.0
        
        let totalWidth = view.bounds.width
        let availableWidth = totalWidth - (2*padding) - (2*stackViewPadding)
        let itemWidth = availableWidth/3
        
        for row in 0..<numberofRows {
            let hstack = UIStackView()
            hstack.axis = .horizontal
    
            hstack.spacing = padding
            for column in 0...2 {
                let index = row * 3 + column
                // Correct the condition to check if index exceeds array size
                guard index <= compatibleSigns.count-1 else {
                    // Add spacer view to maintain layout if needed
                    let spacerView = UIView()
                    spacerView.translatesAutoresizingMaskIntoConstraints = false
                    NSLayoutConstraint.activate([
                        spacerView.widthAnchor.constraint(equalToConstant: itemWidth),
                        spacerView.heightAnchor.constraint(equalToConstant: itemWidth + 40.0)
                    ])
                    hstack.addArrangedSubview(spacerView)
                    continue
                }
                
                let sign = compatibleSigns[(row*3 + column)]
                let signView = SignView()
                signView.setUp(image: sign.image , title: sign.rawValue)
                signView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    signView.heightAnchor.constraint(equalToConstant: itemWidth + 40.0),
                    signView.widthAnchor.constraint(equalToConstant: itemWidth)
                ])
                hstack.addArrangedSubview(signView)
            }
            
            compatibilityStackView.addArrangedSubview(hstack)
        }
        
        personalityTraitLabel.text = Constants.personalityTraits
        personalityTraitValue.numberOfLines = 0
        personalityTraitValue.text = traits.personalityTraits
    }
    
    func createBulletPointString(items: [String]) -> NSAttributedString {
        let bullet = "•  "
        let resStr = NSMutableAttributedString()
        for item in items {
            let formattedItem = "\(bullet)\(item)\n"
            let attributes = [NSAttributedString.Key.font: UIFont(name: Font.typeWriter, size: 20) ?? .systemFont(ofSize: 20), ]
            let formattedString = NSAttributedString(string: formattedItem, attributes: attributes)
            resStr.append(formattedString)
        }
        
        return resStr
    }
}

