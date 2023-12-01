//
//  EpisodesTableVIewCell.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 21.11.2023.
//

import UIKit
import SnapKit

final class EpisodesTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    
    enum LocalConstants {
        static let episodeFontSize: CGFloat = 13
        static let dateFontSize: CGFloat = 12
        static let episodeString = "Episode"
        static let seasonString = "Season"
    }
    
    // MARK: - Subviews
    
    private lazy var vInner: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = CornerRadius.medium
        view.backgroundColor = R.color.cardColor()
        return view
    }()
    
    private lazy var lblEpisodeName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = .boldSystemFont(ofSize: LocalConstants.episodeFontSize)
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var lblEpisodeInfo: UILabel = {
        let lbl = UILabel()
        lbl.textColor = R.color.greenTextColor()
        lbl.font = .boldSystemFont(ofSize: LocalConstants.episodeFontSize)
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var lblDate: UILabel = {
        let lbl = UILabel()
        lbl.textColor = R.color.greyNormalTextColor()
        lbl.font = .boldSystemFont(ofSize: LocalConstants.dateFontSize)
        lbl.textAlignment = .center
        return lbl
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        contentView.backgroundColor = R.color.screenColor()
        contentView.addSubviews(vInner,
                                lblEpisodeName,
                                lblEpisodeInfo,
                                lblDate)
    }
    
    private func setupConstraints() {
        vInner.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Paddings.small)
            $0.horizontalEdges.equalToSuperview().inset(Paddings.large)
            $0.bottom.equalToSuperview().inset(Paddings.large)
        }
        
        lblEpisodeName.snp.makeConstraints {
            $0.top.equalTo(vInner).inset(Paddings.medium)
            $0.leading.equalTo(vInner).inset(Paddings.medium)
        }
        
        lblEpisodeInfo.snp.makeConstraints {
            $0.top.equalTo(lblEpisodeName).inset(Paddings.large)
            $0.leading.equalTo(vInner).inset(Paddings.medium)
            $0.bottom.equalTo(vInner).inset(Paddings.medium)
        }
        
        lblDate.snp.makeConstraints {
            $0.top.equalTo(lblEpisodeName).inset(Paddings.large)
            $0.trailing.equalTo(vInner).inset(Paddings.medium)
            $0.bottom.equalTo(vInner).inset(Paddings.medium)
        }
    }
    
    func fill(episodeName: String, episodeValue: String, seasonValue: String, episodeDate: String) {
        lblEpisodeName.text = episodeName
        lblEpisodeInfo.text = "\(LocalConstants.episodeString) \(episodeValue), \(LocalConstants.seasonString) \(seasonValue)"
        lblDate.text = episodeDate
    }
}
