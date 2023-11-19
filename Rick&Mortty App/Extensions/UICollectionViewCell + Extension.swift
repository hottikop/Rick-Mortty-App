//
//  UICollectionViewCell + Extension.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 18.11.2023.
//

import UIKit

extension UICollectionViewCell {
    static var reuseId: String {
        let className = String(describing: self)
        return className + "Id"
    }
}
