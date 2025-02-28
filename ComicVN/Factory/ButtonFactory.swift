import UIKit
import CoreFoundation

class ButtonFactory {
    static func createButton(_ title: String? = nil, image: UIImage? = nil, imageColor: UIColor? = UIColor(hex: "#FF7B00"), locationImageRight: Bool = false, font: UIFont = .bold18, textColor: UIColor = UIColor(hex: "#FFFFFF"), bgColor: UIColor = UIColor(hex: "#FF7B00"), rounded: Bool = true, height: CGFloat? = 48, padding: CGFloat? = nil) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = font
        button.setTitleColor(textColor, for: .normal)
        button.backgroundColor = bgColor
        button.layer.cornerRadius = rounded ? 6 : 0
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        if let height = height {
            button.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if let image = image {
            button.setImage(image, for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            button.tintColor = imageColor
//            
//            if locationImageRight {
//                if let titleLabelWidth = button.titleLabel?.frame.size.width {
//                    button.imageEdgeInsets = UIEdgeInsets(top: 0, left: titleLabelWidth + 8, bottom: 0, right: 0)
//                }
//                if let imageViewWidth = button.imageView?.frame.size.width {
//                    button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageViewWidth - 8, bottom: 0, right: 0)
//                }
//            } else {
//                button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
//            }
            
            button.titleAndIcon(hspacing: padding ?? 0)
            
        }
        return button
    }
    
  
}
