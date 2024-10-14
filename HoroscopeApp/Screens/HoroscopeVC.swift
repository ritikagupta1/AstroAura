//
//  HoroscopeVC.swift
//  HoroscopeApp
//
//  Created by Ritika Gupta on 07/10/24.
//

import UIKit

class HoroscopeVC: ScrollableVC {
    let dateLabel = TitleLabel(font: UIFont(name: Font.baskerVilleBoldItalic, size: 26), alignment: .center)
    let horizontalScrollView = UIScrollView()
    let horizontalScrollContentView = UIView()
    let buttonStack = UIStackView()
    
    let overallReading = UILabel()
    let workReading = UILabel()
    let relationshipReading = UILabel()
    let wellbeingReading = UILabel()
    
    var selectedSign: Sign?
    var selectedTimePeriod: HoroscopeTimePeriod?
    
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
        
        if  let button = buttonStack.arrangedSubviews.first(where: { view in
          (view as? UIButton)?.titleLabel?.text == HoroscopeTimePeriod.day.rawValue
        }) as? UIButton {
           button.isSelected = true
           button.layer.borderColor = button.isSelected ? UIColor.button.cgColor : UIColor.label.cgColor
       }
        self.selectedTimePeriod = .day
        getHoroscopeReading(sign: selectedSign, timePeriod: .day)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let rightButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareHoroscope))
        rightButton.tintColor = .button
        self.tabBarController?.navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func shareHoroscope() {
        guard let sharedText = self.createSharedHoroscope() else {
            return
        }
        
        let shareSheetVC = UIActivityViewController(activityItems: [sharedText], applicationActivities: nil)
        
        present(shareSheetVC,animated: true)
    }
    
    private func configure() {
        contentView.addSubview(dateLabel)
        horizontalScrollView.showsHorizontalScrollIndicator = false
        
        horizontalScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(horizontalScrollView)
        
        horizontalScrollContentView.translatesAutoresizingMaskIntoConstraints = false
        horizontalScrollView.addSubview(horizontalScrollContentView)
        
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalScrollContentView.addSubview(buttonStack)
        
        overallReading.numberOfLines = 0
        overallReading.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(overallReading)
        
        workReading.numberOfLines = 0
        workReading.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(workReading)
        
        relationshipReading.numberOfLines = 0
        relationshipReading.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(relationshipReading)
        
        wellbeingReading.numberOfLines = 0
        wellbeingReading.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(wellbeingReading)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            dateLabel.heightAnchor.constraint(equalToConstant: 28),
            
            horizontalScrollView.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 20),
            horizontalScrollView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 10),
            horizontalScrollView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            horizontalScrollView.heightAnchor.constraint(equalTo: horizontalScrollContentView.heightAnchor),
            
            horizontalScrollContentView.topAnchor.constraint(equalTo: self.horizontalScrollView.topAnchor),
            horizontalScrollContentView.leadingAnchor.constraint(equalTo: self.horizontalScrollView.leadingAnchor),
            horizontalScrollContentView.trailingAnchor.constraint(equalTo: self.horizontalScrollView.trailingAnchor),
            horizontalScrollContentView.bottomAnchor.constraint(equalTo: horizontalScrollView.bottomAnchor),
            
            
            buttonStack.topAnchor.constraint(equalTo: horizontalScrollContentView.topAnchor),
            buttonStack.leadingAnchor.constraint(equalTo: horizontalScrollContentView.leadingAnchor),
            buttonStack.trailingAnchor.constraint(equalTo: horizontalScrollContentView.trailingAnchor),
            buttonStack.bottomAnchor.constraint(equalTo: horizontalScrollContentView.bottomAnchor),
            
            
            overallReading.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 15),
            overallReading.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            overallReading.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            workReading.topAnchor.constraint(equalTo: overallReading.bottomAnchor, constant: 15),
            workReading.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            workReading.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            relationshipReading.topAnchor.constraint(equalTo: workReading.bottomAnchor, constant: 15),
            relationshipReading.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            relationshipReading.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            wellbeingReading.topAnchor.constraint(equalTo: relationshipReading.bottomAnchor, constant: 10),
            wellbeingReading.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            wellbeingReading.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            wellbeingReading.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
        
        buttonStack.axis = .horizontal
        buttonStack.spacing = 12
        buttonStack.distribution = .fillEqually
        
        
        for buttonType in HoroscopeTimePeriod.allCases {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(buttonType.rawValue, for: .normal)
            button.setTitleColor(.label, for: .normal)
            button.setTitleColor(.button, for: .selected)
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.label.cgColor
            button.layer.cornerRadius = 12
            button.widthAnchor.constraint(equalToConstant: 100).isActive = true
            button.heightAnchor.constraint(equalToConstant: 40).isActive = true
            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            buttonStack.addArrangedSubview(button)
        }
    }
    
    
    func getHoroscopeReading(sign: Sign?, timePeriod: HoroscopeTimePeriod) {
        guard let selectedSign = selectedSign else {
            return
        }
        self.showLoadingView()
        NetworkManager.shared.getHoroscopeReading(
            sign: selectedSign,
            timePeriod: timePeriod) { result in
                self.dismissLoadingView()
                switch result {
                case .success(let reading):
                    DispatchQueue.main.async {
                        self.setUpHoroscopeReading(horoscopeReading: reading)
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
    
    
    @objc func buttonClicked(sender: UIButton) {
        buttonStack.arrangedSubviews.forEach { view in
            if let button = view as? UIButton {
                button.isSelected = (button == sender)
                button.layer.borderColor = button.isSelected ? UIColor.button.cgColor : UIColor.label.cgColor
            }
        }
        let timePeriod = HoroscopeTimePeriod(rawValue: sender.titleLabel?.text ?? "") ?? .day
        self.selectedTimePeriod = timePeriod
        self.getHoroscopeReading(sign: selectedSign, timePeriod: timePeriod)
    }
    
    func setUpHoroscopeReading(horoscopeReading: Horoscope) {
        dateLabel.text = "\(horoscopeReading.startDate) - \(horoscopeReading.endDate)"
        overallReading.attributedText = createText(title: Constants.overall , text: horoscopeReading.horoscope.overall)
        workReading.attributedText = createText(title: Constants.workAndCareer, text: horoscopeReading.horoscope.workCareer)
        relationshipReading.attributedText = createText(title: Constants.loveAndRelationships, text: horoscopeReading.horoscope.loveRelationship)
        wellbeingReading.attributedText = createText(title: Constants.healthAndWellbeing , text: horoscopeReading.horoscope.health)
    }
    
    
    func createText(title: String, text: String) -> NSAttributedString {
        let attributes = [NSAttributedString.Key.font: UIFont(name: Font.typeWriterBold, size: 24) ?? .systemFont(ofSize: 22)]
        let title = NSAttributedString(string: "\(title): \n" , attributes: attributes)
        let completeText = NSMutableAttributedString()
        completeText.append(title)
        let textAttributes = [NSAttributedString.Key.font: UIFont(name: Font.typeWriter, size: 18) ?? .systemFont(ofSize: 20)]
        let readingText = NSAttributedString(string: text, attributes: textAttributes )
        completeText.append(readingText)
        return completeText
    }
    
    
    func createSharedHoroscope() -> String? {
        guard let selectedSign = selectedSign, let selectedTimePeriod = selectedTimePeriod, let overallReading = overallReading.text, let wellbeingReading = wellbeingReading.text, let workReadingReading = workReading.text, let relationShipReading = relationshipReading.text else {
            return nil
        }
        var sharedText =  "\(selectedTimePeriod.rawValue) - Horoscope Reading for \(selectedSign.rawValue): \n"
        sharedText.append("\(overallReading)\n")
        sharedText.append("\(wellbeingReading)\n")
        sharedText.append("\(relationShipReading)\n")
        sharedText.append("\(workReadingReading)\n")
        return sharedText
    }
}

enum HoroscopeTimePeriod: String, CaseIterable, Codable {
    case day = "Daily"
    case week = "Weekly"
    case month = "Monthly"
    case year = "Yearly"
    
    var expirationTimeInterval: TimeInterval {
        switch self {
        case .day:
            return 24 * 60 * 60
        case .week:
            return 7 * 24 * 60 * 60
        case .month:
            return 30 * 24 * 60 * 60
        case .year:
            return 365 * 24 * 60 * 60
        }
    }
}
