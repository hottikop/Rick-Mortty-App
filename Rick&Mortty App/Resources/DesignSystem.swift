//
//  DesignSystem.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 23.11.2023.
//

import UIKit

enum Paddings {
    static let small = 8
    static let medium = 16
    static let large = 24
    static let huge = 36
}

enum CornerRadius {
    static let small: CGFloat = 10
    static let medium: CGFloat = 16
}

struct Size {
    private static let screenHeight: CGFloat = 812
    private static let screenWidth: CGFloat = 375
    
    private static let cardHeight = 202
    private static let cardWidth = 156
    
    static let cardSize: CGSize = CGSize(
        width: CGFloat(screenWidth) * (CGFloat(cardWidth) / CGFloat(screenWidth)),
        height: CGFloat(screenWidth) * (CGFloat(cardHeight) / CGFloat(screenWidth))
    )
    
    static let cardInsets: UIEdgeInsets = UIEdgeInsets(top: screenHeight * 0.02, left: screenWidth * 0.05, bottom: screenHeight * 0.02, right: screenWidth * 0.07)
}
