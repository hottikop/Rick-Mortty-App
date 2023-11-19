//
//  Endpoint.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 15.11.2023.
//

import Foundation

struct Endpoint {
    var scheme: String = Constants.Network.scheme
    var host: String = Constants.Network.host
    var path: String = Constants.Network.path
    var queryItems: [URLQueryItem]

    init(path: String = Constants.Network.path, queryItems: [URLQueryItem] = []) {
        self.path = path
        self.queryItems = queryItems
    }
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems

        guard let url = components.url else {
            preconditionFailure("Failed to load \(components)")
        }
        return url
    }
}
