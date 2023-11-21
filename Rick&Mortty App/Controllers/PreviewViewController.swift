//
//  PreviewViewController.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 17.08.2023.
//

protocol PreviewViewControllerDelegate: AnyObject {
    func previewViewController(_ vc: PreviewViewController, willShow characterInfo: Results)
}

import UIKit

final class PreviewViewController: UIViewController {
    
    //MARK: - Properties
    
    weak var delegate: PreviewViewControllerDelegate?
    private var characters: [CharactersModel] = []
    private var currentPage = 0
    private var isLoading = false
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width * 0.42, height: view.frame.width * 0.53)

        layout.sectionInset = UIEdgeInsets(top: view.frame.height * 0.02, left: view.frame.width * 0.05, bottom: view.frame.height * 0.02, right: view.frame.width * 0.07)
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var cvCharacterList: UICollectionView = {
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
        cvCharacterList.reloadData()
    }
    
    //MARK: - Methods
    
    private func setupNavBar() {
        let navBar = navigationController?.navigationBar
        navBar?.barTintColor = UIColor(named: Constants.Colors.screenColor)
        navBar?.prefersLargeTitles = true
        navigationItem.backButtonTitle = ""
    }
    
    private func setupUI() {
        title = Constants.Strings.previewTitle
        view.addSubview(cvCharacterList)
    }
    
    private func setupConstraints() {
        cvCharacterList.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func loadData() {
        if isLoading { return }
        isLoading = true

        currentPage += 1

        let queryItems = [URLQueryItem(name: Constants.Network.page, value: String(currentPage))]

        NetworkDataFetch.shared.fetchData(queryItems: queryItems, responseType: CharactersModel.self) { [weak self] character, _ in
            guard let character else { return }
            self?.characters.append(character)
            self?.cvCharacterList.reloadData()
            self?.isLoading = false
        }
    }
    
    private func loadImage(indexPath: IndexPath, completion: @escaping (UIImage) -> Void) {
        let id = characters[indexPath.row / Constants.Values.charactersCount].results[indexPath.row % Constants.Values.charactersCount].id
        let path = Constants.Network.imagePath + String(id) + ".jpeg"
        
        NetworkDataFetch.shared.fetchImage(path: path) { newImage, _ in
            let image = newImage ?? UIImage()
            completion(image)
        }
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
        
        let results = characters[indexPath.item / Constants.Values.charactersCount].results
        
        loadImage(indexPath: indexPath) { image in
            cell.fill(with: image, name: results[indexPath.item % Constants.Values.charactersCount].name)
        }
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        let lastItem = collectionView.numberOfItems(inSection: indexPath.section) - 1
        
        guard !isLoading && indexPath.item == lastItem else { return }
        
        loadData()
    }
    
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        false
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let result = characters[indexPath.item / Constants.Values.charactersCount]
            .results[indexPath.item % Constants.Values.charactersCount]
        
        let vc = InfoViewController(result)
        navigationController?.pushViewController(vc, animated: true)
    }
}
