//
//  InfoViewController.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 20.11.2023.
//

import UIKit

final class InfoViewController: UIViewController {
    
    //MARK: - Properties
    
    private var charactersService: CharactersService
    private var results: Results?
    private var image: UIImage?
    private var episodes: [EpisodeModel] = []
    
    private lazy var tblCharacterInfo: UITableView = {
        let tbl = UITableView()
        tbl.backgroundColor = UIColor(named: Constants.Colors.screenColor)
        tbl.delegate = self
        tbl.dataSource = self
        tbl.sectionHeaderTopPadding = 0.0
        tbl.registerSeveralCells(CharacterTableViewCell.self,
                                 InfoTableViewCell.self,
                                 OriginTableViewCell.self,
                                 EpisodesTableViewCell.self)
        return tbl
    }()
    
    //MARK: - Initializers
    
    init(_ results: Results,
         charactersService: CharactersService = CharactersService()) {
        self.results = results
        self.charactersService = charactersService
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
        
        charactersService.loadImage(characters: nil, indexPath: nil, id: id) { newImage in
            let image = newImage
            completion(image)
            
            DispatchQueue.main.async {
                self.tblCharacterInfo.reloadData()
            }
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
    
    enum TableSection: Int, CaseIterable, CustomStringConvertible {
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = TableSection(rawValue: section) else {
            return 0
        }
        
        switch section {
        case .characterInfoSection, .infoSection, .originSection:
            return 1
        case .episodeSection:
            return results?.episode.count ?? 0
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
                
                if let episodeInfo = getEpisodeInfo(episode.episode) {
                    let episodeValue = episodeInfo[0]
                    let seasonValue = episodeInfo[1]
                    let episodeDate = episode.airDate
                    
                    cell.fill(episodeName: episodeName, episodeValue: episodeValue, seasonValue: seasonValue, episodeDate: episodeDate)
                }
            }
            
            return cell
        }
    }
}

//MARK: - UITableViewDelegate

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
