//
//  UICollectionView.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 18.11.2023.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: T.reuseId, for: indexPath) as? T ?? T()
    }
    
    func register(_ cellType: UICollectionViewCell.Type) {
        register(cellType, forCellWithReuseIdentifier: cellType.reuseId)
    }
}
