//
//  UIView + Extensions.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 22.11.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
