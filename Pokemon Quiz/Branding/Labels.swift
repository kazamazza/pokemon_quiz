import Foundation
import UIKit

class UILabelTitleThumbnail: UILabel {
    override var text: String? {
        didSet {
            customize()
        }
    }
}

extension UILabelTitleThumbnail: BrandLabelling {
    func customize() {
        if self.text != nil {
            self.textAlignment = .center
            self.font = UIFont(name: "HelveticaNeue", size: FontSizes.small.rawValue)
            self.textColor = UIColor.brandWhite
            super.text = text?.uppercased()
        }
    }
}

class UILabelTitleChannel: UILabel {
    override var text: String? {
        didSet {
            customize()
        }
    }
}

extension UILabelTitleChannel: BrandLabelling {
    func customize() {
        if self.text != nil {
            self.textAlignment = .center
            self.font = UIFont(name: "HelveticaNeue-Bold", size: FontSizes.large.rawValue)
            self.textColor = UIColor.brandWhite
            super.text = text?.uppercased()
        }
    }
}


class UILabelTitleCategory: UILabel {
    override var text: String? {
        didSet {
            customize()
        }
    }
}

extension UILabelTitleCategory: BrandLabelling {
    func customize() {
        if self.text != nil {
            self.textAlignment = .center
            self.font = UIFont(name: "HelveticaNeue-Bold", size: FontSizes.small.rawValue)
            self.textColor = UIColor.brandWhite
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
