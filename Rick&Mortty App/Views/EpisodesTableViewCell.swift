//
//  EpisodesTableVIewCell.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 21.11.2023.
//

import UIKit
import SnapKit

final class EpisodesTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    private lazy var vInner: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 16
        view.backgroundColor = UIColor(named: Constants.Colors.cardColor)
        return view
    }()
    
    private lazy var lblEpisodeName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = .boldSystemFont(ofSize: 13)
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var lblEpisodeInfo: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: Constants.Colors.greenText)
        lbl.font = .boldSystemFont(ofSize: 13)
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var lblDate: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: Constants.Colors.greyNormalText)
        lbl.font = .boldSystemFont(ofSize: 12)
        lbl.textAlignment = .center
        return lbl
    }()
    
    //MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setupUI() {
        contentView.backgroundColor = UIColor(named: Constants.Colors.screenColor)
        contentView.addSubview(vInner)
        contentView.addSubview(lblEpisodeName)
        contentView.addSubview(lblEpisodeInfo)
        contentView.addSubview(lblDate)
    }
    
    private func setupConstraints() {
        vInner.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(24)
        }
        
        lblEpisodeName.snp.makeConstraints {
            $0.top.equalTo(vInner).inset(16)
            $0.leading.equalTo(vInner).inset(15.25)
        }
        
        lblEpisodeInfo.snp.makeConstraints {
            $0.top.equalTo(lblEpisodeName).inset(25)
            $0.leading.equalTo(vInner).inset(15.25)
            $0.bottom.equalTo(vInner).inset(16)
        }
        
        lblDate.snp.makeConstraints {
            $0.top.equalTo(lblEpisodeName).inset(25)
            $0.trailing.equalTo(vInner).inset(16)
            $0.bottom.equalTo(vInner).inset(16)
        }
    }
    
    func fill(episodeName: String, episodeValue: String, seasonValue: String, episodeDate: String) {
        lblEpisodeName.text = episodeName
        lblEpisodeInfo.text = "Episode \(String(describing: episodeValue)), Season \(String(describing: seasonValue))"
        lblDate.text = episodeDate
    }
}
