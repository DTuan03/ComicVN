//
//  UITextField.swift
//  ComicVN
//
//  Created by Tuấn on 25/2/25.
//
import UIKit

extension UITextField {
    func imageLeftView(image: String, placeholder: String) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let imageView = UIImageView(image: UIImage(systemName: image))
        imageView.tintColor = .black
        imageView.frame = CGRect(x: 15, y: 15, width: 20, height: 20)
        imageView.contentMode = .scaleAspectFill
        paddingView.addSubview(imageView)
        
        self.leftView = paddingView
        self.leftViewMode = .always
        self.keyboardType = .default
        if placeholder == "passWord" {
            self.isSecureTextEntry = true
        }
    }
    
    func imageRightView(image: String, placeholder: String = "") {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let imageView = UIImageView(image: UIImage(systemName: image))
        imageView.tintColor = .black
        imageView.frame = CGRect(x: 15, y: 15, width: 20, height: 20)
        imageView.contentMode = .scaleAspectFill
        paddingView.addSubview(imageView)
        
        if !placeholder.isEmpty {
            self.placeholder = NSLocalizedString(placeholder, comment: "")
        }
        self.rightView = paddingView
        self.rightViewMode = .always
        self.keyboardType = .default

        let tap = UITapGestureRecognizer(target: self, action: #selector((toggleSecureTextEntry(_:))))
        paddingView.addGestureRecognizer(tap)
    }
    
    @objc func toggleSecureTextEntry(_ sender: UITapGestureRecognizer) {
        if let paddingView = sender.view, let imageView = paddingView.subviews.first as? UIImageView {
            if self.isSecureTextEntry {
                self.isSecureTextEntry = false
                imageView.image = UIImage(systemName: "eyes")
            } else {
                self.isSecureTextEntry = true
                imageView.image = UIImage(systemName: "eyebrow")
            }
        }
    }
}
