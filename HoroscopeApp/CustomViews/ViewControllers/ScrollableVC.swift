//
//  HeaderViewController.swift
//  HoroscopeApp
//
//  Created by Ritika Gupta on 04/10/24.
//

import UIKit

protocol ScrollDelegate: AnyObject {
    var headerHeight: CGFloat { get }
    func scrollViewDidScroll(offset: CGFloat)
}

class ScrollableVC: UIViewController {
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    weak var delegate: ScrollDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configure()
    }
    
    
    override func viewDidLayoutSubviews() {
        let headerHeight = delegate?.headerHeight ?? 0
        scrollView.contentInset = UIEdgeInsets(top: headerHeight, left: 0, bottom: 0, right: 0)
    }
   
    private func configure() {
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        ])
    }
}

extension ScrollableVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y + scrollView.contentInset.top
        delegate?.scrollViewDidScroll(offset: offset)
    }
}

class ScrollableDataLoadingVC: ScrollableVC {
    var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showLoadingView() {
        containerView = UIView(frame: self.view.bounds)
        view.addSubview(containerView ?? UIView())
        containerView?.backgroundColor = .systemBackground
        containerView?.alpha = 0.0
       
        UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        containerView?.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView?.centerXAnchor ?? self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView?.centerYAnchor ?? self.view.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25) {
                self.containerView.alpha = 0
                self.containerView?.removeFromSuperview()
                self.containerView = nil
            }
        }
    }
}
