//
//  UIViewController+Ext.swift
//  HoroscopeApp
//
//  Created by Ritika Gupta on 03/10/24.
//

import UIKit
extension UIViewController {
    func presentAlertViewController(title: String, message: String, buttonTitle: String, buttonAction: @escaping () -> Void) {
        let alertVC = AlertViewController(title: title, message: message, buttonTitle: buttonTitle, buttonAction: buttonAction)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        self.present(alertVC, animated: true)
    }
}
