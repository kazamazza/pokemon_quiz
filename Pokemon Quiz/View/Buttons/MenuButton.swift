import Foundation
import UIKit

class MenuButton: UIButton {
    
    var delegate: StackViewSelectable? {
        didSet {
            guard let delegate = delegate else {return}
            let tap = UITapGestureRecognizer(target: delegate,
                                             action: #selector(delegate.didSelectStackViewItem))
            addGestureRecognizer(tap)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.font = UIFont(name: "HelveticaNeue", size: FontSizes.small.rawValue)
        titleLabel?.textColor = UIColor.brandWhite
        layer.borderWidth = 0.0
        layer.cornerRadius = 8
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
