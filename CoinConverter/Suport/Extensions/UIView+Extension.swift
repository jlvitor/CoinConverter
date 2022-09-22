//
//  UIView+Extension.swift
//  CoinConverter
//
//  Created by Jean Lucas Vitor on 21/09/22.
//

import UIKit

extension UIView {
    
    func showAlert(view: UIViewController, title: String? = "Atenção", message: String, btnTitle: String? = "OK") {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: btnTitle, style: .default))
        
        view.present(alert, animated: true)
    }
}
