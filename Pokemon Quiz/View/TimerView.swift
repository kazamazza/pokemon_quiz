import UIKit

class TimerView: UIView {

    let counter = UILabelCounter()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .brandPink
        addSubview(counter)
        counter.text = "GET READY!!!"
        setCounterLabelConstraints()
    }
    
    private func setCounterLabelConstraints() {
        counter.translatesAutoresizingMaskIntoConstraints = false
        let constraints  = [counter.centerXAnchor.constraint(equalTo:                               centerXAnchor),
                            counter.centerYAnchor.constraint(equalTo: centerYAnchor)]
            
            NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
