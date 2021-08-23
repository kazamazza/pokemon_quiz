import UIKit

struct PokemonForm: Codable
{
    let name: String
    let url: String
}


struct Pokemon: Codable {
    let name: String
    let imagePath: String
    
    enum CodingKeys: String, CodingKey {
        case imagePath = "front_default"
        case name
        case sprites
        case other
        case officialArtwork = "official-artwork"
        case forms
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let sprites = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .sprites)
        let other = try sprites.nestedContainer(keyedBy: CodingKeys.self, forKey: .other)
        let aw = try other.nestedContainer(keyedBy: CodingKeys.self, forKey: .officialArtwork)
        imagePath = try aw.decode(String.self, forKey: .imagePath)
        let forms = try container.decode([PokemonForm].self, forKey: .forms)
        name = forms.first!.name
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var sprites = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .sprites)
        var other = sprites.nestedContainer(keyedBy: CodingKeys.self, forKey: .other)
        var aw = other.nestedContainer(keyedBy: CodingKeys.self, forKey: .officialArtwork)
        try aw.encode(imagePath, forKey: .imagePath)

    }
}

struct PokemonData: Codable {
    let name: String
    let url: String
}

struct PokemonRoster: Codable {
    let results: [PokemonData]
}
