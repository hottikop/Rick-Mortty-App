//
//  CharacterTableViewCell.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 20.11.2023.
//

import UIKit
import SnapKit

final class CharacterTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    private lazy var vImage: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 16
        img.layer.masksToBounds = true
        return img
    }()
    
    private lazy var lblName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = .boldSystemFont(ofSize: 22)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private lazy var lblStatus: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: Constants.Colors.greenText)
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
        
        contentView.addSubview(vImage)
        contentView.addSubview(lblName)
        contentView.addSubview(lblStatus)
    }
    
    private func setupConstraints() {
        vImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.size.equalTo(148)
        }
        
        lblName.snp.makeConstraints {
            $0.top.equalTo(vImage.snp.bottom).inset(-24)
            $0.centerX.equalToSuperview()
        }
        lblStatus.snp.makeConstraints {
            $0.top.equalTo(lblName.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func fill(image: UIImage?, name: String?, status: String?) {
        vImage.image = image
        lblName.text = name
        lblStatus.text = status
    }
}
