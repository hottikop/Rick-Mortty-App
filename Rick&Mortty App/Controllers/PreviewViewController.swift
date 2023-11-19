//
//  PreviewViewController.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 17.08.2023.
//

import UIKit

class PreviewViewController: UIViewController {
    
    //MARK: - Properties
    
    private var characters: [CharactersModel] = []
    private var currentPage = 0
    private var isLoading = false
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 156, height: 202)
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var cvCharacter: UICollectionView = {
        let cv = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        cv.register(CardCollectionViewCell.self)
        cv.backgroundColor = UIColor(named: Constants.Colors.screenColor)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupUI()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        cvCharacter.reloadData()
    }
    
    //MARK: - Methods
    
    private func loadData() {
        if isLoading { return }
        isLoading = true

        currentPage += 1

        let queryItems = [URLQueryItem(name: Constants.Network.page, value: String(currentPage))]

        NetworkDataFetch.shared.fetchData(queryItems: queryItems, responseType: CharactersModel.self) { [weak self] character, _ in
            guard let character else { return }
            self?.characters.append(character)
            self?.cvCharacter.reloadData()
            self?.isLoading = false
        }
    }
    
    private func loadImage(indexPath: IndexPath, completion: @escaping (UIImage) -> Void) {
        let id = characters[indexPath.row / 20].results[indexPath.row % 20].id
        let path = Constants.Network.imagePath + String(id) + ".jpeg"
        
        NetworkDataFetch.shared.fetchImage(path: path) { newImage, _ in
            let image = newImage ?? UIImage()
            completion(image)
        }
    }
    
    private func setupNavBar() {
        let navBar = navigationController?.navigationBar
        navBar?.barTintColor = UIColor(named: Constants.Colors.screenColor)
        navBar?.prefersLargeTitles = true
    }
    
    private func setupUI() {
        title = Constants.Strings.previewTitle
        view.addSubview(cvCharacter)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cvCharacter.topAnchor.constraint(equalTo:view.topAnchor, constant: 0),
            cvCharacter.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            cvCharacter.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            cvCharacter.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        false
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension PreviewViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = characters.reduce(0, { $0 + $1.results.count })
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CardCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        
        let results = characters[indexPath.item / 20].results
        
        loadImage(indexPath: indexPath) { image in
            cell.fill(with: image, name: results[indexPath.item % 20].name)
        }
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        let lastItem = collectionView.numberOfItems(inSection: indexPath.section) - 1
        
        guard !isLoading && indexPath.item == lastItem else { return }
        
        loadData()
    }
}
