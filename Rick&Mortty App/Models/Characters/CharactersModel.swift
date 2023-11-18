import Foundation

struct CharactersModel: Decodable {
    var info: Info
    var results: [Results]
}

struct Info: Decodable {
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
}

struct Results: Decodable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: Origin
    var location: Location
    var image: String
    var episode: [String]
    var url: String
    var created: String
}

struct Origin: Decodable {
    var name: String
    var url: String
}

struct Location: Decodable {
    var name: String
    var url: String
}

extension Results {
    enum FieldType: Int, CaseIterable {
        case id = 0
        case name
        case status
        case species
        case type
        case gender
        case origin
        case location
        case image
        case episode
        case url
        case created
    }
}
