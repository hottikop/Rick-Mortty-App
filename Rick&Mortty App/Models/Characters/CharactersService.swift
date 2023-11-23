//
//  CharactersService.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 23.11.2023.
//

import UIKit

final class CharactersService {
    
    //MARK: - Properties
    
    private var networkDataFetch: NetworkDataFetch
    
    //MARK: - Initializer
    
    init(networkDataFetch: NetworkDataFetch = NetworkDataFetch()) {
        self.networkDataFetch = networkDataFetch
    }
    
    //MARK: - Methods
    
    func loadCharacter(currentPage: Int, completion: @escaping (CharactersModel) -> Void) {
        
        let queryItems = [URLQueryItem(name: Constants.Network.page, value: String(currentPage))]
        
        networkDataFetch.fetchData(queryItems: queryItems, responseType: CharactersModel.self) { character, _ in
            guard let character else { return }
            
            completion(character)
        }
    }
    
    func loadImage(characters: [CharactersModel]?, indexPath: IndexPath?, id: Int, completion: @escaping (UIImage) -> Void) {
        
        let path = Constants.Network.imagePath + String(id) + ".jpeg"
        
        networkDataFetch.fetchImage(path: path) { image, _ in
            completion(image ?? UIImage())
        }
    }
    
    func loadEpisode(fromEpisodeURL episodeURL: String, completion: @escaping (EpisodeModel?, NetworkError?) -> Void) {

        guard let path = parseEpisodePath(from: episodeURL) else { return }
        
        networkDataFetch.fetchData(path: path, responseType: EpisodeModel.self) { episode, error in
            completion(episode, error)
        }
    }
    
    private func parseEpisodePath(from episodeURL: String) -> String? {
        do {
            let regex = try NSRegularExpression(pattern: "/([^/]+)$", options: [])
            if let match = regex.firstMatch(in: episodeURL,
                                            options: [],
                                            range: NSRange(location: 0,
                                                           length: episodeURL.utf16.count)) {
                
                let range = Range(match.range(at: 1), in: episodeURL)
                if let value = range.map({ String(episodeURL[$0]) }) {
                    return Constants.Network.episodePath + value
                }
            }
        } catch {
            print("\(error)")
        }
        
        return nil
    }
}
