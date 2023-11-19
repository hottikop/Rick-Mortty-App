//
//  NetworkRequest.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 15.11.2023.
//

import Foundation

class NetworkRequest {
    static let shared = NetworkRequest()
    
    private init() {}
    
    func getData(path: String = Constants.Network.path, queryItems: [URLQueryItem] = [],
                 completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            let endpoint = Endpoint(path: path, queryItems: queryItems)
            
            URLSession.shared.request(endpoint) { data, _, error in
                if let error {
                    let urlError = NetworkError.urlError(originalError: error)
                    completionHandler(.failure(urlError))
                    return
                }
                guard let data else {
                    
                    completionHandler(.failure(.defaultError))
                    return
                }
                
                completionHandler(.success(data))

            }
        }
    }
}
