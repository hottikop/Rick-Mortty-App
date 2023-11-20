//
//  InfoTableViewCell.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 20.11.2023.
//

import UIKit
import SnapKit

final class InfoTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    private lazy var vInner: UIView = {
        let v = UIView()
        v.layer.masksToBounds = true
        v.layer.cornerRadius = 16
        v.backgroundColor = UIColor(named: Constants.Colors.cardColor)
        return v
    }()
    
    private lazy var lblSpecies: UILabel = {
        let lbl = UILabel()
        lbl.text = "Species:"
        lbl.textColor = UIColor(named: Constants.Colors.greyNormalText)
        lbl.font = .boldSystemFont(ofSize: 16)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private lazy var lblType: UILabel = {
        let lbl = UILabel()
        lbl.text = "Type:"
        lbl.textColor = UIColor(named: Constants.Colors.greyNormalText)
        lbl.font = .boldSystemFont(ofSize: 16)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private lazy var lblGender: UILabel = {
        let lbl = UILabel()
        lbl.text = "Gender:"
        lbl.textColor = UIColor(named: Constants.Colors.greyNormalText)
        lbl.font = .boldSystemFont(ofSize: 16)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private lazy var lblSpeciesValue: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = .boldSystemFont(ofSize: 16)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private lazy var lblTypeValue: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = .boldSystemFont(ofSize: 16)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private lazy var lblGenderValue: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = .boldSystemFont(ofSize: 16)
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
        contentView.addSubview(lblSpecies)
        contentView.addSubview(lblType)
        contentView.addSubview(lblGender)
        contentView.addSubview(lblSpeciesValue)
        contentView.addSubview(lblTypeValue)
        contentView.addSubview(lblGenderValue)
    }
    
    private func setupConstraints() {
        vInner.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview()
        }
        
        lblSpecies.snp.makeConstraints {
            $0.top.equalTo(vInner.snp.top).inset(16)
            $0.leading.equalTo(vInner.snp.leading).inset(16)
        }
        
        lblType.snp.makeConstraints {
            $0.top.equalTo(lblSpecies.snp.bottom).inset(-16)
            $0.leading.equalTo(vInner.snp.leading).inset(16)
        }
        
        lblGender.snp.makeConstraints {
            $0.top.equalTo(lblType.snp.bottom).inset(-16)
            $0.leading.equalTo(vInner.snp.leading).inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        lblSpeciesValue.snp.makeConstraints {
            $0.top.equalTo(vInner.snp.top).inset(16)
            $0.trailing.equalTo(vInner.snp.trailing).offset(-16)
        }
        
        lblTypeValue.snp.makeConstraints {
            $0.top.equalTo(lblSpeciesValue.snp.bottom).inset(-16)
            $0.trailing.equalTo(vInner.snp.trailing).offset(-16)
        }
        
        lblGenderValue.snp.makeConstraints {
            $0.top.equalTo(lblTypeValue.snp.bottom).inset(-16)
            $0.trailing.equalTo(vInner.snp.trailing).offset(-16)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    func fill(species: String?, type: String?, gender: String?) {
        lblSpeciesValue.text = species
        lblTypeValue.text = type
        lblGenderValue.text = gender
    }
}
