//
//  HoroscopeDetailsVC.swift
//  HoroscopeApp
//
//  Created by Ritika Gupta on 03/10/24.
//

import UIKit
class HoroscopeDetailsVC: UITabBarController {
    var headerView = HeaderView()
    var selectedSign: Sign?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
    }
    
    init(sign: Sign) {
        super.init(nibName: nil, bundle: nil)
        self.selectedSign = sign
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configure() {
        self.configureHeaderView()
        guard let selectedSign = selectedSign else {
            return
        }
        let traitVC = TraitsVC(selectedSign: selectedSign)
        traitVC.tabBarItem = UITabBarItem(title: Constants.traits, image: .astrology.withRenderingMode(.alwaysOriginal), tag: 0)
        traitVC.delegate = self
        
        let horoscopeVC = HoroscopeVC()
        horoscopeVC.tabBarItem = UITabBarItem(title: Constants.horoscope, image: .crystal.withRenderingMode(.alwaysOriginal), tag: 1)
        horoscopeVC.delegate = self
        
        self.viewControllers = [traitVC, horoscopeVC]
        delegate = self
    }
    
    private func configureHeaderView() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .systemRed
        
        self.view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        headerView.setup(with: selectedSign ?? .aries)
    }
}

extension HoroscopeDetailsVC: ScrollDelegate, UITabBarControllerDelegate {
    var headerHeight: CGFloat{
        self.headerView.frame.height
    }
    
    func updateHeaderPosition(offset: CGFloat) {
        let maxOffset = self.headerView.frame.height
        let minOffset: CGFloat = 0
        let currentOffset = max(minOffset, min(maxOffset, offset))
        
        headerView.transform = CGAffineTransform(translationX: 0, y: -currentOffset)
    }
    
    func scrollViewDidScroll(offset: CGFloat) {
        self.updateHeaderPosition(offset: offset)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let selectedVC = viewController as? ScrollableVC {
            let offset = selectedVC.scrollView.contentOffset.y + selectedVC.scrollView.contentInset.top
            self.updateHeaderPosition(offset: offset)
        }
    }
}
