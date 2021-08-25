import UIKit

class GameViewControllerView: NativeView {
    
    var timerView: TimerView!
    var optionsView: UIStackView!
    var supportsView: UIStackView!
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
        configureTimerView()
    }
    
    private func configureTimerView() {
        timerView = TimerView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height * 0.05))
        addSubview(timerView)
        setTimerViewConstraints()
    }
    
    private func setTimerViewConstraints() {
        timerView.translatesAutoresizingMaskIntoConstraints = false
        let constraints  = [timerView.topAnchor.constraint(equalTo: characterView.bottomAnchor),
                            timerView.leadingAnchor.constraint(equalTo: leadingAnchor),
                            timerView.trailingAnchor.constraint(equalTo: trailingAnchor),
                            timerView.heightAnchor.constraint(equalToConstant: timerView.frame.height)]
        NSLayoutConstraint.activate(constraints)
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
        let constraints  = [optionsView.topAnchor.constraint(equalTo: timerView.bottomAnchor),
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
        configureSupports()
        setNeedsLayout()
    }
    
    private func configureSupports() {
        supportsView = UIStackView()
        supportsView.axis = .horizontal
        supportsView.distribution = .fillEqually
        supportsView.spacing = 20
        supportsView.isLayoutMarginsRelativeArrangement = true
        supportsView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 5, bottom: 16, trailing: 5)
        supportsView.addBackground(color: .brandNavyBlue)
        addSubview(supportsView)
        let reducer = SupportButton()
        reducer.setTitle("50/50", for: .normal)
        reducer.delegate = (self.viewContoller as! StackViewSelectable)
        let timeBoost = SupportButton()
        timeBoost.setTitle("+ 10 secs", for: .normal)
        timeBoost.delegate = (self.viewContoller as! StackViewSelectable)
        supportsView.addArrangedSubviews(views: [reducer,timeBoost])
        setSupportsConstraints()
    }
    
    private func setSupportsConstraints() {
        supportsView.translatesAutoresizingMaskIntoConstraints = false
        let constraints  = [supportsView.topAnchor.constraint(equalTo: optionsView.bottomAnchor),
                            supportsView.leadingAnchor.constraint(equalTo: leadingAnchor),
                            supportsView.trailingAnchor.constraint(equalTo: trailingAnchor),
                            supportsView.bottomAnchor.constraint(equalTo: bottomAnchor)]
            NSLayoutConstraint.activate(constraints)
    }
}
