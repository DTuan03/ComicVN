import UIKit
import CoreFoundation

class ButtonFactory {
    static func createButton(_ title: String? = nil, image: UIImage? = nil, imageColor: UIColor? = UIColor(hex: "#FF7B00"), locationImageRight: Bool = false, font: UIFont = .bold18, textColor: UIColor = UIColor(hex: "#FFFFFF"), bgColor: UIColor = UIColor(hex: "#FF7B00"), rounded: Bool = true, padding: CGFloat? = nil) -> UIButton {
        let button = UIButton()
        button.setTitle(NSLocalizedString(title ?? "", comment: ""), for: .normal)
        button.titleLabel?.font = font
        button.setTitleColor(textColor, for: .normal)
        button.backgroundColor = bgColor
        button.layer.cornerRadius = rounded ? 6 : 0
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        if let image = image {
            button.setImage(image, for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            button.tintColor = imageColor
            button.titleAndIcon(hspacing: padding ?? 0)
            
        }
        return button
    }
}
