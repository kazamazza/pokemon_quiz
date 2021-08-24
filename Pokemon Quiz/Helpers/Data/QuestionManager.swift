import Foundation

class QuestionManager: NSObject {
    
    let questionCount = 2
    var characters: [Character]?
    var questionQueue = [Question]()
    private var index = 0
    
    init(characters: [Character]) {
        super.init()
        self.characters = characters
        self.generateQuestions()
    }
    
    func next() -> Question? {
        guard index < questionQueue.count else {return nil}
        let question = questionQueue[index]
        index += 1
        return question
    }
    
    private func generateQuestions() {
        guard let characters = characters else {return}
        
        var pool = characters
        print(pool.count)
        for _ in 0...questionCount - 1 {
            var options = [Character]()
            for _ in 0...3 {
                let number = Int.random(in: 0..<pool.count)
                let character = pool[number]
                pool.remove(at: number)
                options.append(character)
            }
            let question = Question(options: options)
            questionQueue.append(question)
            options = []
        }
    }
}
