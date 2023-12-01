//
//  InfoTableViewCell.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 20.11.2023.
//

import UIKit
import SnapKit

final class InfoTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    
    enum LocalConstants {
        static let labelSize: CGFloat = 16
        static let speciesTitle = "Species:"
        static let typeTitle = "Type:"
        static let genderTitle = "Gender:"
    }
    
    // MARK: - Subviews
    
    private lazy var vInner: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = CornerRadius.medium
        view.backgroundColor = R.color.cardColor()
        
        return view
    }()
    
    private lazy var lblSpecies: UILabel = {
        let lbl = UILabel()
        lbl.text = LocalConstants.speciesTitle
        lbl.textColor = R.color.greenTextColor()
        lbl.font = .boldSystemFont(ofSize: LocalConstants.labelSize)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private lazy var lblType: UILabel = {
        let lbl = UILabel()
        lbl.text = LocalConstants.typeTitle
        lbl.textColor = R.color.greenTextColor()
        lbl.font = .boldSystemFont(ofSize: LocalConstants.labelSize)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private lazy var lblGender: UILabel = {
        let lbl = UILabel()
        lbl.text = LocalConstants.genderTitle
        lbl.textColor = R.color.greenTextColor()
        lbl.font = .boldSystemFont(ofSize: LocalConstants.labelSize)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private lazy var lblSpeciesValue: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = .boldSystemFont(ofSize: LocalConstants.labelSize)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private lazy var lblTypeValue: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = .boldSystemFont(ofSize: LocalConstants.labelSize)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private lazy var lblGenderValue: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = .boldSystemFont(ofSize: LocalConstants.labelSize)
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
    
    // MARK: - Public Methods
    
    func fill(species: String?, type: String?, gender: String?) {
        lblSpeciesValue.text = species
        lblTypeValue.text = type
        lblGenderValue.text = gender
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        contentView.backgroundColor = R.color.screenColor()
        contentView.addSubviews(vInner,
                                lblSpecies,
                                lblType,
                                lblGender,
                                lblSpeciesValue,
                                lblTypeValue, 
                                lblGenderValue)
    }
    
    private func setupConstraints() {
        vInner.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Paddings.small)
            $0.horizontalEdges.equalToSuperview().inset(Paddings.large)
            $0.bottom.equalToSuperview()
        }
        
        lblSpecies.snp.makeConstraints {
            $0.top.equalTo(vInner.snp.top).inset(Paddings.medium)
            $0.leading.equalTo(vInner.snp.leading).inset(Paddings.medium)
        }
        
        lblType.snp.makeConstraints {
            $0.top.equalTo(lblSpecies.snp.bottom).inset(-Paddings.medium)
            $0.leading.equalTo(vInner.snp.leading).inset(Paddings.medium)
        }
        
        lblGender.snp.makeConstraints {
            $0.top.equalTo(lblType.snp.bottom).inset(-Paddings.medium)
            $0.leading.equalTo(vInner.snp.leading).inset(Paddings.medium)
            $0.bottom.equalToSuperview().inset(Paddings.medium)
        }
        
        lblSpeciesValue.snp.makeConstraints {
            $0.top.equalTo(vInner.snp.top).inset(Paddings.medium)
            $0.trailing.equalTo(vInner.snp.trailing).offset(-Paddings.medium)
        }
        
        lblTypeValue.snp.makeConstraints {
            $0.top.equalTo(lblSpeciesValue.snp.bottom).inset(-Paddings.medium)
            $0.trailing.equalTo(vInner.snp.trailing).offset(-Paddings.medium)
        }
        
        lblGenderValue.snp.makeConstraints {
            $0.top.equalTo(lblTypeValue.snp.bottom).inset(-Paddings.medium)
            $0.trailing.equalTo(vInner.snp.trailing).offset(-Paddings.medium)
            $0.bottom.equalTo(vInner).inset(Paddings.medium)
        }
    }
}
