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
    private var episodes: [EpisodeModel] = []
    
    private lazy var tblCharacterInfo: UITableView = {
        let tbl = UITableView()
        tbl.backgroundColor = UIColor(named: Constants.Colors.screenColor)
        tbl.delegate = self
        tbl.dataSource = self
        tbl.sectionHeaderTopPadding = 0.0
        tbl.register(CharacterTableViewCell.self)
        tbl.register(InfoTableViewCell.self)
        tbl.register(OriginTableViewCell.self)
        tbl.register(EpisodesTableViewCell.self)
        return tbl
    }()
    
    //MARK: - Initializers
    
    init(_ results: Results) {
        self.results = results
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage { newImage in
            self.image = newImage
        }
        loadEpisodes()
        setupUI()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    private func loadEpisodes() {
        guard let results else { return }
        
        for ep in results.episode {
            var path = ""
            
            do {
                let regex = try NSRegularExpression(pattern: "/([^/]+)$", options: [])
                if let match = regex.firstMatch(in: ep, options: [], range: NSRange(location: 0, length: ep.utf16.count)) {
                    let range = Range(match.range(at: 1), in: ep)
                    if let value = range.map({ String(ep[$0]) }) {
                        path = Constants.Network.episodePath + value
                    }
                }
            } catch {
                print("\(error)")
            }
            
            NetworkDataFetch.shared.fetchData(path: path, responseType: EpisodeModel.self) { [weak self] episode, _ in
                
                guard let episode else { return }
                self?.episodes.append(episode)
                self?.tblCharacterInfo.reloadData()
            }
        }
    }
    
    private func getEpisodeInfo(_ input: String) -> [String]? {
        let regexPattern = #"S(\d+)E(\d+)"#
        
        guard let regex = try? NSRegularExpression(pattern: regexPattern) else {
            return nil
        }
        
        guard let match = regex.firstMatch(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count)) else {
            return nil
        }

        guard let seasonRange = Range(match.range(at: 1), in: input),
              let episodeRange = Range(match.range(at: 2), in: input),
              let season = Int(input[seasonRange]),
              let episode = Int(input[episodeRange]) else {
            return nil
        }

        let seasonNumber = String(season)
        let episodeNumber = String(episode)
        
        return [episodeNumber, seasonNumber]
    }
}

//MARK: - UITableViewDataSource

extension InfoViewController: UITableViewDataSource {
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
        guard let results else { return UITableViewCell()}
        switch indexPath.section {
        case 0:
            let cell: CharacterTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            
            let name = results.name
            let status = results.status
            
            cell.fill(image: image, name: name, status: status)
            return cell
        case 1:
            let cell: InfoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            
            let species = results.species
            let type = results.type.isEmpty ? "None" : results.type
            let gender = results.gender
            
            cell.fill(species: species, type: type , gender: gender)
            return cell
            
        case 2:
            let cell: OriginTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            
            let planet = results.origin.name
            
            cell.fill(origin: planet)
            return cell
            
        case 3:
            let cell: EpisodesTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            
            if episodes.count == self.results?.episode.count {
                
                let episodeName = episodes[indexPath.row].name
                
                let episodeInfo = getEpisodeInfo(episodes[indexPath.row].episode)
                let episodeValue = episodeInfo?[0]
                let seasonValue = episodeInfo?[1]
                let episodeDate = episodes[indexPath.row].airDate
                
                cell.fill(episodeName: episodeName, episodeValue: episodeValue ?? "", seasonValue: seasonValue ?? "", episodeDate: episodeDate)
            }
            
            return cell
            
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
}

//MARK: - UITableViewDelegate

extension InfoViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        4
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
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = .white
        }
    }
}
