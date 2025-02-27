//
//  UILabel.swift
//  ComicVN
//
//  Created by Tuấn on 26/2/25.
//

import UIKit

extension UILabel {
    func highlightText(fullText: String, highlightTexts: [String], highlightColor: UIColor) {
        let mutableAttributedString = NSMutableAttributedString(string: fullText)
        
        for highlightText in highlightTexts {
            let range = (fullText as NSString).range(of: highlightText)
            mutableAttributedString.addAttribute(.foregroundColor, value: highlightColor, range: range)
        }
        
        self.attributedText = mutableAttributedString
    }
}
