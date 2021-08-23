import Foundation
import CoreData

class PokemonDataStore: NSObject {
    
    let operationQueue = OperationQueue()
    private var apiService: PokemonAPIClient!
    private var dbHelper: CoreDataHelper!
    private var pokemon: [Pokemon]?
    private var offset = 0
    private var rosterComplete = false
    typealias PokemonRosterCallback = ([PokemonData]?) -> ()
    typealias PokemonCallback = (Pokemon) -> ()
    
    override init() {
        super.init()
        self.apiService = PokemonAPIClient()
        self.dbHelper = CoreDataHelper()
    }
     
    func load() {
        downloadRoster { [weak self] roster in
                guard let self = self else {return}
                guard let roster = roster else {return}
                self.offset += 100
                self.downloadCharacterData(from: roster)
        }
    }
    
    func persistPokemon(pokemon: Pokemon) {
        let result = dbHelper.fetch(entity: .Character, predicate: NSPredicate(
            format: "name == %@", pokemon.name
        ))
        if result?.count == 0 {
            dbHelper.persist { [weak self] in
                guard let self = self else {return}
                let moc = self.dbHelper.persistentContainer.viewContext
                let character = Character(context: moc)
                character.name = pokemon.name
            }
        }
    }
    
    private func downloadRoster(completion: @escaping PokemonRosterCallback) {
        operationQueue.addOperation { [weak self] in
            guard let self = self else {return}
            self.apiService.getRoster(offset: self.offset) {characters in
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
}
