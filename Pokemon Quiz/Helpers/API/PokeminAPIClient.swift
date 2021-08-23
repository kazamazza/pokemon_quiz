import Foundation

class PokemonAPIClient: APIClient {
    
    let endpoint = "https://pokeapi.co/api/v2/"
    typealias PokemonRosterCallback = ([PokemonData]?) -> Void
    typealias PokemonCallback = (Pokemon?) -> Void
    
    lazy var httpClient: HttpClient = {
        return HttpClient()
    }()
    
    func getRoster(offset: Int, completion : @escaping PokemonRosterCallback) {
        let limit = 100
        let requestURL = URL(string: "\(endpoint)pokemon?limit=\(limit)&offset=\(offset)")
        guard let url = requestURL else {completion(nil); return}
        httpClient.get(url: url) {data, error in
            guard error == nil else { completion(nil); return }
            guard let data = data else {
              completion(nil)
              return
            }
            let results = try? JSONDecoder().decode(PokemonRoster.self, from: data).results
            completion(results)
        }
    }
    
    func getPokemon(name: String, completion: @escaping PokemonCallback) {
        let requestURL = URL(string: "\(endpoint)pokemon/\(name)")
        guard let url = requestURL else {completion(nil); return}
        httpClient.get(url: url) {data, error in
            guard error == nil else { completion(nil); return }
            guard let data = data else {
              completion(nil)
              return
            }
            let results = try? JSONDecoder().decode(Pokemon.self, from: data)
            completion(results)
        }
    }
}
