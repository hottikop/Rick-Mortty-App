//
//  Constants.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 15.11.2023.
//

import UIKit

struct Constants {
    struct Network {
        static let scheme = "https"
        static let host = "rickandmortyapi.com"
        static let path = "/api/character"
        static let imagePath = "/api/character/avatar/"
        static let episodePath = "/api/episode/"
        static let page = "page"
    }
    
    struct Strings {
        static let somethigWrong = "somethigWrong"
        static let previewTitle = "Characters"
    }
    
    struct Values {
        static let charactersCount = 20
    }
}

