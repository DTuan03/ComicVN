//
//  LabelFactory.swift
//  ComicVN
//
//  Created by Tuấn on 25/2/25.
//

import UIKit

class LabelFactory {
    static func createLabel(text: String? = nil, font: UIFont = .medium14, textColor: UIColor = UIColor(hex: "#FF7B00"), textAlignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.text = NSLocalizedString(text ?? "", comment: "")
        label.font = font
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        return label
    }
}
