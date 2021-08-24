import Foundation

struct Question {
    var options: Array<Character>
    lazy var correct: Character = {
        return self.generateCorrectAnswer()
    }()
    var result = false
    
    init(options: [Character]) {
        self.options = options
    }
    
    private mutating func generateCorrectAnswer() -> Character {
        let number = Int.random(in: 0..<options.count)
        return options[number]
    }
    
    mutating func answer(_ item: Character) -> Bool {
        result = item == correct ? true : false
        return result
    }
}
