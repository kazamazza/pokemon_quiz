import Foundation

class QuestionViewModel: NSObject, ViewModel {
    
    var observable = Observable<[Question]>()
    var questionsReady = Observable<[Bool]>()
    private var questionManager: QuestionManager!
    private var dataStore: PokemonDataStore!
    
    override init() {
        super.init()
        self.dataStore = PokemonDataStore()
        self.dataStore.delegate = self
    }
    
    func load() {
        dataStore.load()
    }
    
    func nextQuestion() -> Question? {
        return self.questionManager.next()
    }
    
    func bindToObservable(observable: Observable<[Character]>) {
        observable.bind { characters in
            self.questionManager = QuestionManager(characters: characters)
            self.questionsReady.value = [true]
        }
    }
}
