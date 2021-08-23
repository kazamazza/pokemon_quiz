import Foundation

class QuestionViewModel: NSObject {
    
    var observable = Observable<[Question]>()
    private var questionManager: QuestionManager!
    private var dataStore: PokemonDataStore!
    
    override init() {
        super.init()
        self.questionManager = QuestionManager()
        self.dataStore = PokemonDataStore()
        load()
    }
    
    private func load() {
        dataStore.load()
    }
}
