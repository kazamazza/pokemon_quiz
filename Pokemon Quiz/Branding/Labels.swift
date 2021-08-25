import Foundation
import UIKit

class UILabelCounter: UILabel {
    override var text: String? {
        didSet {
            customize()
        }
    }
}

extension UILabelCounter: BrandLabelling {
    func customize() {
        if self.text != nil {
            self.textAlignment = .center
            self.font = UIFont(name: "HelveticaNeue", size: FontSizes.large.rawValue)
            self.textColor = UIColor.brandWhite
            super.text = text?.uppercased()
        }
    }
}

class UILabelOptionButton: UILabel {
    override var text: String? {
        didSet {
            customize()
        }
    }
}

extension UILabelOptionButton: BrandLabelling {
    func customize() {
        if self.text != nil {
            self.textAlignment = .center
            self.font = UIFont(name: "HelveticaNeue-Bold", size: FontSizes.large.rawValue)
            self.textColor = UIColor.brandWhite
            super.text = text?.uppercased()
        }
    }
}


class UILabelMenuButton: UILabel {
    override var text: String? {
        didSet {
            customize()
        }
    }
}

extension UILabelMenuButton: BrandLabelling {
    func customize() {
        if self.text != nil {
            self.textAlignment = .center
            self.font = UIFont(name: "HelveticaNeue-Bold", size: FontSizes.small.rawValue)
            self.text = text?.uppercased()
            self.textColor = UIColor.brandPurple
        }
    }
}

class UILabelBody: UILabel {
    override var text: String? {
        didSet {
            customize()
        }
    }
}

extension UILabelBody: BrandLabelling {
    func customize() {
        if self.text != nil {
            self.textAlignment = .center
            self.font = UIFont(name: "HelveticaNeue", size: FontSizes.medium.rawValue)
            self.textColor = UIColor.brandBlack
        }
    }
}

class UILabelBodyBold: UILabel {
    override var text: String? {
        didSet {
            customize()
        }
    }
}

extension UILabelBodyBold: BrandLabelling {
    func customize() {
        if self.text != nil {
            self.textAlignment = .center
            self.font = UIFont(name: "HelveticaNeue-Bold", size: FontSizes.medium.rawValue)
            self.textColor = UIColor.brandBlack
            super.text = text?.uppercased()
        }
    }
}

class UILabelDescription: UILabel {
    override var text: String? {
        didSet {
            customize()
        }
    }
}

extension UILabelDescription: BrandLabelling {
    func customize() {
        if self.text != nil {
            self.textAlignment = .center
            self.font = UIFont(name: "HelveticaNeue-Bold", size: FontSizes.small.rawValue)
            self.textColor = UIColor.brandBlack
        }
    }
}
