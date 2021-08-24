import Foundation
import UIKit

enum FontSizes: CGFloat {
    case small = 12.0
    case medium = 14.0
    case large = 20.0
}

extension UIColor {
    static var brandPurple: UIColor {
        return UIColor(red: 0.63, green: 0.46, blue: 0.83, alpha: 1.00)
    }
    static var brandPink: UIColor {
        return UIColor(red: 0.90, green: 0.15, blue: 0.54, alpha: 1.00)
    }
    static var brandBlack: UIColor {
        return UIColor(red: 0.11, green: 0.11, blue: 0.15, alpha: 1.00)
    }
    static var brandWhite: UIColor {
        return UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
    }
    static var brandNavyBlue: UIColor {
        return UIColor(red: 0.05, green: 0.15, blue: 0.34, alpha: 1.00)
    }
    
    static var brandGreenCorrectAnswer: UIColor {
        return UIColor(red: 0.28, green: 1.00, blue: 0.27, alpha: 1.00)
    }
    
    static var brandRedIncorrectAnswer: UIColor {
        return UIColor(red: 0.70, green: 0.19, blue: 0.07, alpha: 1.00)
    }
}
