//
//  PreviewViewController.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 17.08.2023.
//

import UIKit
import SnapKit

protocol PreviewViewControllerDelegate: AnyObject {
    func previewViewController(_ vc: PreviewViewController, willShow characterInfo: Results)
}

final class PreviewViewController: UIViewController {
    
    //MARK: - Properties
    
    private var charactersService: CharactersService
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
    
    //MARK: - Initializers
    
    init(charactersServise: CharactersService = CharactersService()) {
        self.charactersService = charactersServise
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        cvCharacterList.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func loadData() {
        guard !isLoading else { return }
        isLoading = true
        
        currentPage += 1
        
        charactersService.loadCharacter(currentPage: currentPage) { character in

            self.characters.append(character)
            self.cvCharacterList.reloadData()
            self.isLoading = false
        }
        
    }
    
    private func loadImage(indexPath: IndexPath, completion: @escaping (UIImage) -> Void) {
        
        let id = characters[indexPath.row / Constants.Values.charactersCount].results[indexPath.row % Constants.Values.charactersCount].id
        
        charactersService.loadImage(characters: characters, indexPath: indexPath, id: id) { newImage in
        
            completion(newImage)
        }
    }
}


//MARK: - UICollectionViewDataSource

extension PreviewViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.reduce(0, { $0 + $1.results.count })
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CardCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        
        let results = characters[indexPath.item / Constants.Values.charactersCount].results
        
        cell.fill(name: results[indexPath.item % Constants.Values.charactersCount].name)
        
        loadImage(indexPath: indexPath) { image in
            
            guard let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell else { return }
            cell.fillImage(image: image)
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension PreviewViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let lastItem = collectionView.numberOfItems(inSection: indexPath.section) - 1
        
        guard !isLoading && indexPath.item == lastItem else { return }
        
        loadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let result = characters[indexPath.item / Constants.Values.charactersCount]
            .results[indexPath.item % Constants.Values.charactersCount]
        
        let vc = InfoViewController(result)
        navigationController?.pushViewController(vc, animated: true)
    }
}
