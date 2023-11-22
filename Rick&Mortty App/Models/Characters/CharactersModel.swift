import Foundation
import UIKit

//MARK: - CharactersModel

struct CharactersModel: Decodable {
    var info: Info
    var results: [Results]
}

//MARK: - Info

struct Info: Decodable {
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
}

//MARK: - Results

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

//MARK: - Origin

struct Origin: Decodable {
    var name: String
    var url: String
}

//MARK: - Location

struct Location: Decodable {
    var name: String
    var url: String
}

// MARK: - EpisodeModel

struct EpisodeModel: Decodable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}

