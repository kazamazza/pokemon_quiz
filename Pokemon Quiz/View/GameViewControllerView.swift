import UIKit

class GameViewControllerView: NativeView {
    
    var timerView: TimerView!
    var optionsView: OptionsStackView!
    var supportsView: SupportsStackView!
    var characterView: CharacterView!
    var summaryView: SummaryView!
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
        configureOptionsView()
        configureSupportsView()
        configureSummaryView()
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
        optionsView = OptionsStackView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height * 0.5))
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
        let count = optionsView.arrangedSubviews.count
        if count > 0 {
            let _ = optionsView.arrangedSubviews.map {
                $0.removeFromSuperview()
            }
        }
        for option in question.options {
            let button = OptionButton()
            button.setTitle(option.name, for: .normal)
            button.delegate = (self.viewContoller as! ViewSelectable)
            optionsView.addArrangedSubview(button)
        }
        optionsView.setNeedsLayout()
    }
    
    func updateOptionsWithReduceAction(remove: [Character]) {
        if let reducer = supportsView.arrangedSubviews.first as? SupportButton {
            reducer.disable()
        }
        for item in remove {
            disableIncorrectOption(option: item)
        }
    }
    
    func updateTimeBoostSupportWithTimeBoostAction() {
        if let timeboost = supportsView.arrangedSubviews[1] as? SupportButton {
            timeboost.disable()
        }
    }
    
    func disableIncorrectOption(option: Character) {
        optionsView.disableIncorrect(option: option)
    }
    
    private func configureSupportsView() {
        supportsView = SupportsStackView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height * 0.5))
        supportsView.delegate = (self.viewContoller as! ViewSelectable)
        addSubview(supportsView)
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
    
    private func configureSummaryView() {
        summaryView = SummaryView(frame: CGRect(x: 0, y: 0, width: frame.width * 0.8, height: frame.height * 0.40))
        summaryView.layer.zPosition = layer.zPosition + 20
        summaryView.isHidden = true
        summaryView.delegate = (self.viewContoller as? ViewSelectable)
        addSubview(summaryView)
        setSummaryViewConstraints()
    }
    
    private func setSummaryViewConstraints() {
        summaryView.translatesAutoresizingMaskIntoConstraints = false
        let constraints  = [summaryView.centerXAnchor.constraint(equalTo:                        centerXAnchor),
                            summaryView.widthAnchor.constraint(equalToConstant: summaryView.frame.width),
                            summaryView.centerYAnchor.constraint(equalTo: centerYAnchor),
                            summaryView.heightAnchor.constraint(equalToConstant: summaryView.frame.height)]
        NSLayoutConstraint.activate(constraints)
    }
    
    func gameOver(score: Int) {
        shadow.isHidden = false
        summaryView.isHidden = false
        summaryView.msg.text = "You score was \(score)"
    }
}
