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
    func request(_ endpoint: Endpoint, _ handler: @escaping Handler) -> URLSessionDataTask {
        let task = dataTask(with: endpoint.url, completionHandler: handler)
        task.resume()
        return task
    }
}
