import Foundation
import UIKit

extension GameViewController: StackViewSelectable {
    func didSelectStackViewItem(sender: Any) {
        guard session.active else {
            return
        }
        let tap = sender as! UITapGestureRecognizer
        if let button = tap.view as? OptionButton {
            guard let tapped = button.titleLabel?.text else{return}
            handleInput(answer: tapped)
        }
    }
        
    func handleInput(answer:String?) {
        if let timer = session.timer {
            timer.invalidate()
        }
        session.freeze()
        guard let name = currentQuestion.correct.name else {return}
        let nativeView = self.nativeView as? GameViewControllerView
        if let optionsView = nativeView?.optionsView {
            optionsView.arrangedSubviews.forEach { view in
                let innerButton = view as! OptionButton
                guard let text = innerButton.titleLabel?.text else{return}
                let color:UIColor = text == name ? .brandGreenCorrectAnswer : .brandRedIncorrectAnswer
                innerButton.highlight(color: color)
            }
        }

        let action: () -> () = answer == currentQuestion.correct.name ? correct: incorrect
        action()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.nextQuestion()
        }
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
