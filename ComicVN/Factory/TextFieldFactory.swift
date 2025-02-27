//
//  TextFieldFactory.swift
//  ComicVN
//
//  Created by Tuấn on 25/2/25.
//

import UIKit

class TextFieldFactory {
    static func createTextField(placeholder: String?, font: UIFont = .bold18, bgColor: UIColor = UIColor(hex: "#DCDBDB", alpha: 0.8), textColor: UIColor = UIColor(hex: "#434040"), textAlignment: NSTextAlignment = .center, rounded: Bool, height: CGFloat?) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.font = font
        textField.backgroundColor = bgColor
        textField.textColor = textColor
        textField.textAlignment = textAlignment
        textField.layer.cornerRadius = rounded ? 5 : 0
        textField.translatesAutoresizingMaskIntoConstraints = false
        if let height = height {
            textField.heightAnchor.constraint(equalToConstant: height).isActive = true
//            textField.widthAnchor.constraint(equalTo: textField.heightAnchor, multiplier: 1).isActive = true
        }
        
        return textField
    }
}
