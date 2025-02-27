//
//  UIViewController.swift
//  ComicVN
//
//  Created by Tuấn on 26/2/25.
//

import UIKit

extension UIViewController {
    func addDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
