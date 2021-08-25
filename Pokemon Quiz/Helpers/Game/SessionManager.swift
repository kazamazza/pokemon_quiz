import Foundation

class SessionManager: NSObject {
    
    private var score = 0
    var correctAnswers = [Question]()
    var timer: Timer?
    var active = false
    weak var delegate: GameViewController! {
        didSet {
            delegate.bindToCounter(observable: counter)
        }
    }
    private var counter = Observable<Int>()

    
    func question() {
        counter.value = 10
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {[weak self] (timer) in
            guard let self = self else {return}
            self.counter.value! -= 1
            if self.counter.value == 0{
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
