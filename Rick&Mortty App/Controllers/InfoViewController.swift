//
//  InfoViewController.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 20.11.2023.
//

import UIKit

final class InfoViewController: UIViewController {
    
    // MARK: - Properties
    
    private var charactersService: CharactersServiceProtocol
    private var results: Results?
    private var image: UIImage?
    private var episodes: [EpisodeModel] = []
    
    private lazy var tblCharacterInfo: UITableView = {
        let tbl = UITableView()
        tbl.backgroundColor = R.color.screenColor()
        tbl.delegate = self
        tbl.dataSource = self
        tbl.sectionHeaderTopPadding = .zero
        tbl.registerSeveralCells(CharacterTableViewCell.self,
                                 InfoTableViewCell.self,
                                 OriginTableViewCell.self,
                                 EpisodesTableViewCell.self)
        return tbl
    }()
    
    // MARK: - Init
    
    init(_ results: Results,
         charactersService: CharactersService = CharactersService()) {
        self.results = results
        self.charactersService = charactersService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage { newImage in
            self.image = newImage
        }
        loadEpisodes()
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Methods
    
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
        navBar?.barTintColor = R.color.screenColor()
    }
    
    private func loadImage(_ completion: @escaping (UIImage) -> Void) {
        guard let results else { return }
        
        let id = results.id
        
        charactersService.loadImage(characters: nil, indexPath: nil, id: id) { newImage in
            let image = newImage
            completion(image)
        }
    }
    
    private func loadEpisodes() {
        guard let results else { return }
        
        let dispatchGroup = DispatchGroup()
        
        for ep in results.episode {
            dispatchGroup.enter()
            
            charactersService.loadEpisode(fromEpisodeURL: ep) { [weak self] episode, _ in
                defer {
                    dispatchGroup.leave()
                }
                
                guard let episode = episode else { return }
                self?.episodes.append(episode)
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.episodes.sort {
                
                guard let index1 = results.episode.firstIndex(of: $0.url),
                      let index2 = results.episode.firstIndex(of: $1.url) else {
                    return false
                }
                return index1 < index2
            }
            
            self?.tblCharacterInfo.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource

extension InfoViewController: UITableViewDataSource {
    
    enum TableSection: Int, CaseIterable {
        case characterInfoSection
        case infoSection
        case originSection
        case episodeSection
        
        var description: String {
            switch self {
            case .infoSection:
                return "Info"
            case .originSection:
                return "Origin"
            case .episodeSection:
                return "Episodes"
            case .characterInfoSection:
                return ""
            }
        }
    }
    
    enum EpisodeInfo: Int {
        case episodeValue
        case seasonValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = TableSection(rawValue: section) else {
            return 0
        }
        
        switch section {
        case .characterInfoSection, .infoSection, .originSection:
            return 1
        case .episodeSection:
            return results?.episode.count ?? .zero
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let results = self.results else { return UITableViewCell() }
        
        guard let section = TableSection(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        switch section {
        case .characterInfoSection:
            let cell: CharacterTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            
            let name = results.name
            let status = results.status
            
            cell.fill(image: image, name: name, status: status)
            return cell
            
        case .infoSection:
            let cell: InfoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            
            let species = results.species
            let type = results.type.isEmpty ? "None" : results.type
            let gender = results.gender
            
            cell.fill(species: species, type: type, gender: gender)
            return cell
            
        case .originSection:
            let cell: OriginTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            
            let planet = results.origin.name
            
            cell.fill(origin: planet)
            return cell
            
        case .episodeSection:
            let cell: EpisodesTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            
            if episodes.count == self.results?.episode.count {
                let episode = episodes[indexPath.row]
                
                let episodeName = episode.name
                
                if let episodeInfo = charactersService.getEpisodeInfo(episode.episode) {
                    
                    let episodeValue = episodeInfo[EpisodeInfo.episodeValue.rawValue]
                    let seasonValue = episodeInfo[EpisodeInfo.seasonValue.rawValue]
                    let episodeDate = episode.airDate
                    
                    cell.fill(episodeName: episodeName, episodeValue: episodeValue, seasonValue: seasonValue, episodeDate: episodeDate)
                }
            }
            
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension InfoViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        TableSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = TableSection(rawValue: section) else {
            return nil
        }
        
        return section.description
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = .white
        }
    }
}
