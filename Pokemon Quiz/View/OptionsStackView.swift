import Foundation
import UIKit

class OptionsStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        distribution = .fillEqually
        spacing = 10
        isLayoutMarginsRelativeArrangement = true
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 5, bottom: 16, trailing: 5)
        addBackground(color: .brandNavyBlue)
    }
    
    func disableIncorrect(option: Character){
        for view in arrangedSubviews {
            let button = view as? OptionButton
            guard let label = button?.titleLabel, let text = label.text else{return}
            guard let name = option.name else {return}
            if text == name.uppercased(){
                button?.disable()
            }
        }
        setNeedsLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
