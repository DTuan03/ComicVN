//
//  TextFieldFactory.swift
//  ComicVN
//
//  Created by Tuấn on 25/2/25.
//

import UIKit

class TextFieldFactory {
    static func createTextField(placeholder: String?, font: UIFont = .bold18, bgColor: UIColor = UIColor(hex: "#DCDBDB", alpha: 0.8), textColor: UIColor = .textSecondaryColor, textAlignment: NSTextAlignment = .left, rounded: Bool) -> UITextField {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.placeholder = NSLocalizedString(placeholder ?? "", comment: "")
        textField.font = font
        textField.backgroundColor = bgColor
        textField.textColor = textColor
        textField.textAlignment = textAlignment
        textField.layer.cornerRadius = rounded ? 5 : 0        
        return textField
    }
}
