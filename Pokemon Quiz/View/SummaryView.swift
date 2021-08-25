import Foundation
import UIKit

class SummaryView: UIView {
    
    let msg = UILabelBody()
    let replay = MenuButton()
    weak var delegate: ViewSelectable? {
        didSet {
            print("summary delegate \(replay)")
            replay.delegate = delegate
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        replay.mode = .Restart
        replay.setTitle("Play Again", for: .normal)
        addSubview(msg)
        addSubview(replay)
        backgroundColor = .yellow
        setMsgConstraints()
        setReplayButtonConstraints()
    }
    
    private func setMsgConstraints() {
        msg.translatesAutoresizingMaskIntoConstraints = false
        let constraints  = [msg.topAnchor.constraint(equalTo: topAnchor, constant: frame.height * 0.15),
                            msg.widthAnchor.constraint(equalToConstant: frame.width),
                            msg.centerXAnchor.constraint(equalTo: centerXAnchor)]
            NSLayoutConstraint.activate(constraints)
    }
    
    private func setReplayButtonConstraints() {
        replay.translatesAutoresizingMaskIntoConstraints = false
        let constraints  = [replay.centerXAnchor.constraint(equalTo:                        centerXAnchor),
                            replay.widthAnchor.constraint(equalToConstant: frame.width),
                            replay.centerYAnchor.constraint(equalTo: centerYAnchor)]
            NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
