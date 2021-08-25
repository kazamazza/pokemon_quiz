import Foundation
import UIKit

class MenuStackView: UIStackView {
    
    let play = MenuButton()
    weak var delegate: ViewSelectable? {
        didSet {
            play.delegate = delegate
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .horizontal
        distribution = .fillEqually
        spacing = 20
        isLayoutMarginsRelativeArrangement = true
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 5, bottom: 16, trailing: 5)
        addBackground(color: .brandNavyBlue)
        play.setTitle("Play", for: .normal)
        addArrangedSubviews(views: [play])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
