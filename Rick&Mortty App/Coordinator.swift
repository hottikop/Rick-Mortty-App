//
//  Coordinator.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 01.12.2023.
//

import UIKit

final class Coordinator {
    
    // MARK: - Properties
    
    private weak var navigationController: UINavigationController?
    private let result: Results
    
    // MARK: - Init
    
    init(navigationController: UINavigationController?, result: Results) {
          self.navigationController = navigationController
          self.result = result
      }
    
    // MARK: - Methods
    
    func start() {
        let infoViewController = InfoViewController(result)
        navigationController?.pushViewController(infoViewController, animated: true)
    }
}
