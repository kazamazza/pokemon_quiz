import UIKit

class GameViewControllerView: NativeView {
    
    var optionsView: UIStackView!
    var characterView: CharacterView!
    var background: UIImageView!
    var shadow: UIView!
    
    override func didMoveToWindow() {
        backgroundColor = .red
        shadow = UIView(frame: frame)
        shadow.backgroundColor = .black
        shadow.alpha = 0.8
        shadow.isHidden = true
        addSubview(shadow)
        configureShadowConstraints()
        configureCharacterView()
    }
    
    private func configureShadowConstraints() {
        shadow.layer.zPosition = layer.zPosition + 10
        shadow.translatesAutoresizingMaskIntoConstraints = false
        let constraints  = [shadow.topAnchor.constraint(equalTo: topAnchor),
                            shadow.leadingAnchor.constraint(equalTo: leadingAnchor),
                            shadow.trailingAnchor.constraint(equalTo: trailingAnchor),
                            shadow.bottomAnchor.constraint(equalTo: bottomAnchor)]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureCharacterView() {
        characterView = CharacterView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height * 0.2))
        addSubview(characterView)
        setCharacterViewConstraints()
    }
    
    private func setCharacterViewConstraints() {
        characterView.translatesAutoresizingMaskIntoConstraints = false
        let constraints  = [characterView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                            characterView.leadingAnchor.constraint(equalTo: leadingAnchor),
                            characterView.trailingAnchor.constraint(equalTo: trailingAnchor),
                            characterView.heightAnchor.constraint(equalToConstant: frame.height * 0.20)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureOptionsView(){
        optionsView = UIStackView()
        optionsView.axis = .vertical
        optionsView.distribution = .fillEqually
        optionsView.spacing = 20
        optionsView.isLayoutMarginsRelativeArrangement = true
        optionsView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 5, bottom: 16, trailing: 5)
        optionsView.addBackground(color: .brandNavyBlue)
        addSubview(optionsView)
        setOptionsViewConstraints()
    }
    
    private func setOptionsViewConstraints() {
        optionsView.translatesAutoresizingMaskIntoConstraints = false
        let constraints  = [optionsView.topAnchor.constraint(equalTo: characterView.bottomAnchor),
                            optionsView.leadingAnchor.constraint(equalTo: leadingAnchor),
                            optionsView.trailingAnchor.constraint(equalTo: trailingAnchor),
                            optionsView.heightAnchor.constraint(equalToConstant: frame.height * 0.5)]
            
            NSLayoutConstraint.activate(constraints)
    }
    
    func loadOptions(question: Question) {
        configureOptionsView()
        for option in question.options {
            let button = OptionButton()
            button.setTitle(option.name, for: .normal)
            button.delegate = (self.viewContoller as! StackViewSelectable)
            optionsView.addArrangedSubview(button)
        }
        setNeedsLayout()
    }
}
