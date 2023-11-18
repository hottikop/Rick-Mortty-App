//
//  Endpoint.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 15.11.2023.
//

import Foundation

struct Endpoint {
    var scheme: String = Constants.scheme
    var host: String = Constants.host
    var path: String = Constants.path
    var queryItems: [URLQueryItem]

    init(path: String = Constants.path, queryItems: [URLQueryItem] = []) {
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
