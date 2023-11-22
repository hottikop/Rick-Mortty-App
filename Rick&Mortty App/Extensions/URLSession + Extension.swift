//
//  URLSession + Extension.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 15.11.2023.
//

import Foundation

extension URLSession {
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func request(_ endpoint: Endpoint, _ handler: @escaping Handler) -> URLSessionDataTask? {
        guard let url = endpoint.url else { return nil }
        
        let task = dataTask(with: url, completionHandler: handler)
        task.resume()
        return task
    }
}
