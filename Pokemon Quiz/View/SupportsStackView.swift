import Foundation
import UIKit

class SupportsStackView: UIStackView {
    
    weak var delegate: ViewSelectable? {
        didSet {
            reducer.delegate = delegate
            timeBoost.delegate = delegate
        }
    }
    let reducer = SupportButton()
    let timeBoost = SupportButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .horizontal
        distribution = .fillEqually
        spacing = 10
        isLayoutMarginsRelativeArrangement = true
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 5, bottom: 16, trailing: 5)
        addBackground(color: .brandNavyBlue)
        configureButtons()
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
    
    private func configureButtons() {
        reducer.setTitle("50/50", for: .normal)
        reducer.mode = .fiftyFifty
        timeBoost.setTitle("+ 15 secs", for: .normal)
        timeBoost.mode = .timeBoost
        addArrangedSubviews(views: [reducer,timeBoost])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
