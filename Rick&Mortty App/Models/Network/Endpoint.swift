//
//  Endpoint.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 15.11.2023.
//

import Foundation

//MARK: - Endpoint

struct Endpoint {
    
    //MARK: - Properties
    
    var scheme: String = Constants.Network.scheme
    var host: String = Constants.Network.host
    var path: String = Constants.Network.path
    var queryItems: [URLQueryItem]
    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems

        guard let url = components.url else {
            return nil
        }
        return url
    }
    
    //MARK: - Initializer

    init(path: String = Constants.Network.path, queryItems: [URLQueryItem] = []) {
        self.path = path
        self.queryItems = queryItems
    }
}
