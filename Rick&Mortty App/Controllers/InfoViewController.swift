//
//  InfoViewController.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 20.11.2023.
//

import UIKit

final class InfoViewController: UIViewController {
    
    //MARK: - Properties
    
    private var results: Results?
    private var image: UIImage?
    
    private lazy var tblCharacterInfo: UITableView = {
        let tbl = UITableView()
        tbl.backgroundColor = UIColor(named: Constants.Colors.screenColor)
        tbl.delegate = self
        tbl.dataSource = self
        tbl.register(CharacterTableViewCell.self)
        return tbl
    }()
    
    //MARK: - Initializers
    
    init(_ results: Results) {
        self.results = results
       

        super.init(nibName: nil, bundle: nil)
        self.loadImage { newImage in
            self.image = newImage
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        tblCharacterInfo.reloadData()
    }
    
    //MARK: - Methods
    
    private func setupUI() {
        view.addSubview(tblCharacterInfo)
    }
    
    private func setupConstraints() {
        tblCharacterInfo.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupNavBar() {
        let navBar = navigationController?.navigationBar
        navBar?.barTintColor = UIColor(named: Constants.Colors.screenColor)
        navBar?.prefersLargeTitles = true
    }
    
    private func loadImage(_ completion: @escaping (UIImage) -> Void) {
        guard let results else { return }
        
        let id = results.id
        let path = Constants.Network.imagePath + String(id) + ".jpeg"
        
        NetworkDataFetch.shared.fetchImage(path: path) { newImage, _ in
            let image = newImage ?? UIImage()
            completion(image)
            
            DispatchQueue.main.async {
                self.tblCharacterInfo.reloadData()
            }
        }
    }
}

extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return results?.episode.count ?? 2
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: CharacterTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            
            let name = results?.name
            let status = results?.status
            
            cell.fill(image: image, name: name, status: status)
            
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Info"
        case 2:
            return "Origin"
        case 3:
            return "Episodes"
        default:
            return nil
        }
    }

}
