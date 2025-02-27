//
//  LabelFactory.swift
//  ComicVN
//
//  Created by Tuấn on 25/2/25.
//

import UIKit

class LabelFactory {
    static func createLabel(text: String? = nil, font: UIFont = .medium14, textColor: UIColor = UIColor(hex: "#FF7B00"), textAlignment: NSTextAlignment = .center) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        return label
    }
}
