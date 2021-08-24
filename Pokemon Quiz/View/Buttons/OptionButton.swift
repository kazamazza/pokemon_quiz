import Foundation
import UIKit

class OptionButton: UIButton {
    
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
        titleLabel?.font = UIFont(name: "HelveticaNeue", size: FontSizes.large.rawValue)
        titleLabel?.text = titleLabel?.text?.uppercased()
        titleLabel?.textColor = UIColor.brandPink
        layer.borderWidth = 0.0
        layer.cornerRadius = 8
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func highlight(color: UIColor) {
        backgroundColor = color
    }
}
