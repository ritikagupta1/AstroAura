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
    
    let titleLabel = UILabel()
    let selectDOBLabel = UILabel()
    var collectionView: UICollectionView!
    let datePicker = UIDatePicker()
    
    var counter = 0
    var collectionViewHeightConstraint: NSLayoutConstraint!
    
    //MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        self.layoutUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.updateCollectionViewHeight()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updateCollectionViewHeight()
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
        
        titleLabel.font = UIFont(name: Font.typeWriterBold, size: 26)
        titleLabel.textColor = .label
        titleLabel.text = Constants.selectSignMessage
        
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        selectDOBLabel.font = UIFont(name: Font.typeWriterBold, size: 22)
        selectDOBLabel.textColor = .label
        selectDOBLabel.text = Constants.selectBirthDateMessage

        selectDOBLabel.numberOfLines = 2
        selectDOBLabel.textAlignment = .center
        selectDOBLabel.translatesAutoresizingMaskIntoConstraints = false
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.tintColor = .label
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.date = .now
        datePicker.maximumDate = .now
        datePicker.backgroundColor = .systemBackground
        
        
        
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
            datePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
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
}
