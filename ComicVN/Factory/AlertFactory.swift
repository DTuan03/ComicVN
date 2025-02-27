//
//  AlertFactory.swift
//  ComicVN
//
//  Created by Tuấn on 26/2/25.
//

import UIKit

class UIAlertFactory {
        static func showAlert(on viewController: UIViewController, title: String = "Thông báo", message: String, buttonTitle: String = "OK", completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: buttonTitle, style: .default) { _ in
            completion?()
        }
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
}
