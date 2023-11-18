//
//  NetworkDataFetch.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 15.11.2023.
//

import UIKit

class NetworkDataFetch {
    static let shared = NetworkDataFetch()
    
    private init() {}
    
    func fetchData<T: Decodable>(path: String = Constants.path, queryItems: [URLQueryItem] = [],
                                 responseType: T.Type,
                                 response: @escaping (T?, NetworkError?) -> Void) {
        
        NetworkRequest.shared.getData(path: path, queryItems: queryItems) { result in
            
            switch result {
            
            case .success(let success):
                do {
                    let data = try JSONDecoder().decode(T.self,
                                                        from: success)
                    DispatchQueue.main.async {
                        response(data, nil)
                    }
                    
                } catch let decodeError {
                    print(decodeError)
                    DispatchQueue.main.async {
                        
                        response(nil, .parseDataError(originalError: decodeError))
                    }
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    response(nil, .urlError(originalError: error))
                }
            }
        }
    }
    
    func fetchImage(path: String = Constants.imagePath, completion: @escaping (UIImage?, NetworkError?) -> Void) {
        NetworkRequest.shared.getData(path: path) { result in
            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(image, nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil, .defaultError)
                    }
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(nil, .urlError(originalError: error))
                }
            }
        }
    }
}
