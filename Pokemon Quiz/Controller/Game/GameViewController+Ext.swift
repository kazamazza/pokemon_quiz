import Foundation
import UIKit

extension GameViewController: ViewSelectable {
    
    func didSelectViewItem(sender: Any) {
        let tap = sender as! UITapGestureRecognizer
        guard session.active else {
            if let button = tap.view as? MenuButton{
                handleMenuButton(button: button)
            }
            return
        }
        
        if let button = tap.view as? OptionButton {
            guard let tapped = button.titleLabel?.text else{return}
            handleInput(answer: tapped)
        }
        if let button = tap.view as? SupportButton {
            if button.canSelect {
                handleSupportItem(selection: button)
            }
        }
    }
    
    func handleMenuButton(button: MenuButton) {
        switch button.mode {
        case .Restart:
            restart()
    }
    }
        
   func handleInput(answer:String?) {
        if let timer = session.timer {
            timer.invalidate()
        }
        session.freeze()
        guard let name = currentQuestion.correct.name?.uppercased() else {return}
        let nativeView = self.nativeView as? GameViewControllerView
        if let optionsView = nativeView?.optionsView {
            optionsView.arrangedSubviews.forEach { view in
                let innerButton = view as! OptionButton
                guard let text = innerButton.titleLabel?.text else{return}
                let color:UIColor = text == name ? .brandGreenCorrectAnswer : .brandRedIncorrectAnswer
                innerButton.highlight(color: color)
            }
        }

        let action: () -> () = answer == name ? correct: incorrect
        action()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.nextQuestion()
        }
    }
    
    func handleSupportItem(selection: SupportButton) {
        guard let mode = selection.mode else {
            return
        }
        switch mode {
        case .fiftyFifty:
            session.reduce()
        case .timeBoost:
            session.timeBoost()
        }
        selection.disable()
    }
    
    func correct() {
            do {try AudioHelper.shared.playTrack(name: "correct")}
            catch{}
        session.correct(question: currentQuestion)
    }
        
    func incorrect() {
        do {try AudioHelper.shared.playTrack(name: "incorrect")}
        catch{}
    }

}
