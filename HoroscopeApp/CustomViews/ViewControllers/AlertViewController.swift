//
//  AlertViewController.swift
//  HoroscopeApp
//
//  Created by Ritika Gupta on 03/10/24.
//

import UIKit

class AlertViewController: UIViewController {

    var alertView: AlertView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        configureAlertView()
    }
    
    init(title: String, message: String, buttonTitle: String, buttonAction: @escaping () -> Void) {
        super.init(nibName: nil, bundle: nil)
        self.alertView = AlertView(
            alertTitle: title,
            alertMessage: message,
            buttonTitle: buttonTitle,
            buttonAction: {
                buttonAction()
                self.dismiss(animated: true)
            })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureAlertView() {
        self.view.addSubview(alertView)
        
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            alertView.widthAnchor.constraint(equalToConstant: 280),
            alertView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
}
