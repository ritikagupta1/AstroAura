//
//  ViewController.swift
//  HoroscopeApp
//
//  Created by Ritika Gupta on 25/09/24.
//

import UIKit

class SelectSunSignVC: UIViewController {
    let scrollView =  UIScrollView()
    let contentView = UIView()
    
    let titleLabel = TitleLabel(font: UIFont(name: Font.typeWriterBold, size: 26), numberOfLines: 2)
    let selectDOBLabel = TitleLabel(font: UIFont(name: Font.typeWriterBold, size: 22), alignment: .center, numberOfLines: 2)
    var collectionView: UICollectionView!
    let datePicker = UIDatePicker()
    
    var zodiacSignMapping: [ZodiacSign.Zodiac]?
    var selectedSign: Sign?
    
    var collectionViewHeightConstraint: NSLayoutConstraint!
    
    //MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        self.layoutUI()
        self.loadZodiacSignData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.updateCollectionViewHeight()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updateCollectionViewHeight()
    }
    
    private func loadZodiacSignData() {
        //check if zodiac data is already present in the user defaults
        PersistenceManager.retrieveZodiacData { result in
            switch result {
            case .success(let zodiacData):
                //If successful, store it in the local variable
                self.zodiacSignMapping = zodiacData
                
            case .failure(let error):
                switch error {
                case .noZodiacDataFound:
                    // For the very first time, data wont be there in user defaults,we will need to decode from json file and store it in user defaults
                    self.decodeAndSaveZodiacData()
                    
                default:
                    // .unableToRetrieveZodiacData error will happen when decoding from user default fails, show alert
                    print(error)
                }
            }
        }
    }
    
    private func decodeAndSaveZodiacData() {
        guard let fileURL = Bundle.main.url(forResource: "Zodiac", withExtension: "json") else {
            return
        }
        
        guard let data = try? Data(contentsOf: fileURL) else {
            return
        }
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        dateFormatter.locale = .current
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        guard let zodiacData = try? decoder.decode(ZodiacSign.self, from: data) else {
            return
        }
        
        self.zodiacSignMapping = zodiacData.zodiacs
        if let error = PersistenceManager.addZodiacData(zodiacs: zodiacData.zodiacs) {
            // when saving in to user defaults fail, fail silently
            print("zodiac data couldn't be saved to user default because of \(error)")
        } else {
            // when saving in to user defaults succeeds, succeed silently
            print("zodiac data added successfully to user default")
        }
    }
    
    private func layoutUI() {
        self.view.backgroundColor = .systemBackground
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
//            contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
//            contentView.widthAnchor.constraint(equalToConstant: 1000)
        ])
        
        titleLabel.text = Constants.selectSignMessage
        
        selectDOBLabel.text = Constants.selectBirthDateMessage
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.tintColor = .label
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.date = .now
        datePicker.maximumDate = .now
        datePicker.backgroundColor = .systemBackground
        datePicker.addTarget(self, action: #selector(handleDateSelection), for: .valueChanged)
        
        
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
        contentView.addSubview(selectDOBLabel)
        contentView.addSubview(datePicker)
        
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 90),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: selectDOBLabel.topAnchor),
            
            selectDOBLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            selectDOBLabel.heightAnchor.constraint(equalToConstant: 80),
            selectDOBLabel.bottomAnchor.constraint(equalTo: datePicker.topAnchor, constant: -2),
            
            datePicker.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            datePicker.heightAnchor.constraint(equalToConstant: 40),
            datePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            datePicker.widthAnchor.constraint(equalToConstant: 111)
        ])
        
        collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 0)
        collectionViewHeightConstraint.isActive = true
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewFlowLayout())
        
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(SunSignCell.self, forCellWithReuseIdentifier: SunSignCell.reuseIdentifier)
    }
    
    func updateCollectionViewHeight() {
        // Incase you need to calculate height by doing calculations
//        let padding: CGFloat = 10.0
//        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        let itemHeight = layout.itemSize.height
//        let numberOfRows = ceil(Double(sunSigns.count)/3.0)
//        let height = numberOfRows * (itemHeight + padding * 2)
        //collectionViewHeightConstraint.constant = height
        
        collectionViewHeightConstraint.constant = collectionView.collectionViewLayout.collectionViewContentSize.height
    }
    
    private func createCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        let padding: CGFloat = 10.0
        let minimumSpacing: CGFloat = 15.0
        
        let totalWidth = view.bounds.width
        let availableWidth = totalWidth - (2*minimumSpacing) - (2*padding)
        let itemWidth = availableWidth/3
        
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40.0)
        
        return layout
    }
    
    @objc func handleDateSelection() {
        presentedViewController?.dismiss(animated: true, completion: nil)
        guard let sign = getZodiacSign(date: datePicker.date) else {
            return
        }
        self.selectedSign = sign
        self.presentAlertViewController(
            title: sign.rawValue,
            message: String(format: Constants.zodiacSignMessageFormat, sign.rawValue, sign.rawValue),
            buttonTitle: Constants.continueText, buttonAction: continueClicked)
    }
    
    func continueClicked() {
        guard let selectedSign = selectedSign else {
            return
        }
        print(selectedSign)
    }
    
    func getZodiacSign(date: Date) -> Sign? {
        var sign: Sign?
        
        guard let zodiacSignMapping = zodiacSignMapping else {
            print("Zodiac data not found")
            return nil
        }
        
        let calendar = Calendar.current
        let dateComponent = calendar.dateComponents([.month,.day], from: date)
       
        
        for zodiacSignMap in zodiacSignMapping {
            let startDateComponent = calendar.dateComponents([.month,.day], from: zodiacSignMap.startDate)
            let endDateComponent = calendar.dateComponents([.month, .day], from: zodiacSignMap.endDate)
            
            if startDateComponent.month! <= endDateComponent.month! {
                // normal range such as march 12 - april 21
                // last condition if
                if (dateComponent.month! ==  startDateComponent.month! && dateComponent.day! >= startDateComponent.day!) || (dateComponent.month! == endDateComponent.month! && dateComponent.day! <= endDateComponent.day!) || (dateComponent.month! > startDateComponent.month! && dateComponent.month! < endDateComponent.month!) {
                    sign = zodiacSignMap.zodiacSign
                    break
                }
            } else {
                // round year
                if (dateComponent.month! == startDateComponent.month! && dateComponent.day! >= startDateComponent.day!) ||  (dateComponent.month! == endDateComponent.month! && dateComponent.day! <= endDateComponent.day!) || (dateComponent.month! < startDateComponent.month! && dateComponent.month! < endDateComponent.month!) {
                    sign = zodiacSignMap.zodiacSign
                    break
                }
            }
            
        }
        
        return sign
    }
}

extension SelectSunSignVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sunSigns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SunSignCell.reuseIdentifier, for: indexPath) as? SunSignCell else {
            fatalError("Couldn't dequeue cell")
        }
        let sunsign = sunSigns[indexPath.row]
        cell.setUp(image: sunsign.image , title: sunsign.name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedSign = sunSigns[indexPath.row].sign
        continueClicked()
    }
}
