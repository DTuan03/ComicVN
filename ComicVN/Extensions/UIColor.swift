//
//  UIColor.swift
//  ComicVN
//
//  Created by Tuấn on 25/2/25.
//

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let green = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let blue = CGFloat(rgb & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static let primaryColor = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .light ? UIColor(hex: "#FF7B00") : UIColor(hex: "#FF7B00")
    }
    
    static let textPrimaryColor = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .light ? UIColor(hex: "#000000") : UIColor(hex: "#FFFFFF")
    }
    
    static let textSecondaryColor = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .light ? UIColor(hex: "#434040") : UIColor(hex: "#FFFFFF")
    }
    
    static let backgroundColor = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .light ? UIColor(hex: "#FFFFFF") : UIColor(hex: "#000000")
    }
    
    static let backgroundSecondaryColor = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .light ? UIColor(hex: "#FF7B00", alpha: 0.11) : UIColor(hex: "#FF9E4A", alpha: 0.16)
    }
}
