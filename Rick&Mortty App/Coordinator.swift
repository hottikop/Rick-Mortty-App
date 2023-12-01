//
//  Coordinator.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 01.12.2023.
//

import UIKit

final class Coordinator<T> {
    
    // MARK: - Properties
    
    private weak var navigationController: UINavigationController?
    private let data: T

    // MARK: - Init
    
    init(navigationController: UINavigationController?, data: T) {
        self.navigationController = navigationController
        self.data = data
    }
    
    // MARK: - Methods

    func start() {
        if let infoViewController = createInfoViewController() {
            navigationController?.pushViewController(infoViewController, animated: true)
        } else {
            print("Unsupported type")
        }
    }

    private func createInfoViewController() -> UIViewController? {
        guard let result = data as? Results else {
            return nil
        }
        
        return InfoViewController(result)
    }
}
