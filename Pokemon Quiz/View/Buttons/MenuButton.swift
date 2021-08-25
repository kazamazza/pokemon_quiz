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
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title?.uppercased(), for: state)
        titleLabel!.textAlignment = .center
        titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: FontSizes.large.rawValue)
        setTitleColor(.brandPurple, for: .normal)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = 0.0
        layer.cornerRadius = 8
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
