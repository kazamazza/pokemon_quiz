import Foundation
import UIKit

enum SupportOption: String {
    case fiftyFifty
    case timeBoost
}

class SupportButton: UIButton {
    
    var mode: SupportOption!
    var canSelect = true
    var delegate: ViewSelectable? {
        didSet {
            guard let delegate = delegate else {return}
            let tap = UITapGestureRecognizer(target: delegate,
                                             action: #selector(delegate.didSelectViewItem))
            addGestureRecognizer(tap)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.font = UIFont(name: "HelveticaNeue", size: FontSizes.large.rawValue)
        titleLabel?.text = titleLabel?.text?.uppercased()
        titleLabel?.textColor = UIColor.brandPink
        layer.borderWidth = 0.0
        layer.cornerRadius = 8
        clipsToBounds = true
    }
    
    func disable() {
        alpha = 0.1
        guard let text = titleLabel?.text else {
            return
        }
        titleLabel?.attributedText = text.strikethrough()
        canSelect = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
