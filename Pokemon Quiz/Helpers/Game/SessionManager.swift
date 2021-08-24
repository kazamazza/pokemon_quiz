import Foundation

class SessionManager: NSObject {
    
    private var score = 0
    var correctAnswers = [Question]()
    var counter = 10
    var timer: Timer?
    var active = false
    weak var delegate: GameViewController!
    
    func question() {
        counter = 10
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {[weak self] (timer) in
            guard let self = self else {return}
            self.counter -= 1
            if self.counter == 0{
                self.delegate.handleInput(answer: nil)
                timer.invalidate()
            }
        }
        active = true
    }
    
    func freeze() {
        active = false
    }
    
    func correct(question: Question) {
        self.score += 1
        correctAnswers.append(question)
    }
    
    func report() {
        for var item in correctAnswers {
            let character = item.correct
            character.unlocked = true
        }
    }
    
    func gameOver() {
        active = false
        timer?.invalidate()
        report()
    }
}
