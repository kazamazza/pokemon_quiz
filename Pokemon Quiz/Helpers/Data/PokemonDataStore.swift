import Foundation
import CoreData

class PokemonDataStore: NSObject {
    
    typealias PokemonRosterCallback = ([PokemonData]?) -> ()
    typealias PokemonCallback = (Pokemon) -> ()
    
    let operationQueue = OperationQueue()
    private var observable = Observable<[Character]>()
    private var apiService: PokemonAPIClient!
    private var dbHelper: CoreDataHelper!
    private var pokemon: [Pokemon]?
    private var rosterStatus = (complete:false, offset: 0)
    weak var delegate: QuestionViewModel!
    
    override init() {
        super.init()
        self.apiService = PokemonAPIClient()
        self.dbHelper = CoreDataHelper()
    }
    
    func load() {
        var items: [Character] = []
        let needsUpdates = true
        if needsUpdates {
            updateRoster(offset: rosterStatus.offset)
        }
        bindToObservable()
        let moc =
          dbHelper.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<Character>(entityName: "Character")
          do {
            items = try moc.fetch(fetchRequest)
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
        observable.value = items
    }
     
    func updateRoster(offset: Int) {
        print("update...")
        var shouldContinue = false
        var rosterTask = [PokemonData]()
        let group = DispatchGroup()
        group.enter()
        self.downloadRoster{roster in
            guard let roster = roster else {return}
            
            rosterTask = roster
            if roster.count > 0 {shouldContinue = true}
            group.leave()
        }
        group.wait()
        downloadCharacterData(from: rosterTask)
        self.rosterStatus.offset = offset + 100
        if shouldContinue {
            //updateRoster(offset: self.rosterStatus.offset)
        }
    }
    
    func persistPokemon(pokemon: Pokemon) {
        var items: [NSManagedObject] = []
        let moc =
          dbHelper.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Character")
        fetchRequest.predicate = NSPredicate(
            format: "name == %@", pokemon.name
        )
          do {
            items = try moc.fetch(fetchRequest)
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
        
        guard items.count == 0 else {
            return
        }
        let character = Character(context: moc)
            character.name = pokemon.name
            character.imagePath = pokemon.imagePath
            do {
              try moc.save()
            } catch let error as NSError {
              print("Could not save. \(error), \(error.userInfo)")
            }
    }
    
    private func downloadRoster(completion: @escaping PokemonRosterCallback) {
        operationQueue.addOperation { [weak self] in
            guard let self = self else {return}
            self.apiService.getRoster(offset: self.rosterStatus.offset) {characters in
                guard let roster = characters, roster.count > 0 else {completion(nil);return}
                completion(roster)
        }
    }
}
    
    private func downloadCharacterData(from data: [PokemonData]) {
        let _ = data.map {
            operationQueue.addOperation(PokemonDataLoadOperation(parent: self,
                                                                 pokemonName: $0.name, url: $0.url))
        }
    }
    
    class PokemonDataLoadOperation: Operation {
        unowned let parent: PokemonDataStore!
        let pokemonName: String!
        let url: String!
        
        init(parent: PokemonDataStore, pokemonName: String, url:String) {
            self.parent = parent
            self.pokemonName = pokemonName
            self.url = url
        }
        
        override func main() {
            guard let pokemonName = pokemonName else {return}
            downloadPokemondata(name: pokemonName) { pokemon in
                self.parent.persistPokemon(pokemon: pokemon)
            }
        }
        
        private func downloadPokemondata(name: String, completion: @escaping PokemonCallback) {
            parent.apiService.getPokemon(name: name) {pokemon in
                guard let pokemon = pokemon else {return}
                completion(pokemon)
            }
        }
    }
    
    func bindToObservable() {
        delegate.bindToObservable(observable: observable)
    }
}
