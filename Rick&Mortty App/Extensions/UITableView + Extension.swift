//
//  UITableView + Extension.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 18.11.2023.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: T.reuseId, for: indexPath) as? T ?? T()
    }
    
    func register(_ cellType: UITableViewCell.Type) {
        register(cellType, forCellReuseIdentifier: cellType.reuseId)
    }
}
