//
//  NetworkError.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 15.11.2023.
//

import Foundation

enum NetworkError: Error {
    case urlError(originalError: Error)
    case invalidAPIResponse(httpStatusCode: Int)
    case parseDataError(originalError: Error)
    case defaultError
    
    var localizedDescription: String {
        switch self {
        case .urlError(let originalError):
            return "URL Error: \(originalError.localizedDescription)"
        case .invalidAPIResponse(let httpStatusCode):
            return "Invalid API Response: HTTP Status Code \(httpStatusCode)"
        case .parseDataError(let originalError):
            return "Parse Data Error: \(originalError.localizedDescription)"
        case .defaultError:
            return "Something Wrong"
        }
    }
}
