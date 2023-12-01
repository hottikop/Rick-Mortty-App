//
//  CharacterTableViewCell.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 20.11.2023.
//

import UIKit
import SnapKit

final class CharacterTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    
    enum LocalConstants {
        static let nameFontSize: CGFloat = 22
        static let statusFontSize: CGFloat = 16
        static let imageSize = 148
    }
    
    // MARK: - Subviews
    
    private lazy var vImage: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = CornerRadius.medium
        img.layer.masksToBounds = true
        return img
    }()
    
    private lazy var lblName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = .boldSystemFont(ofSize: LocalConstants.nameFontSize)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private lazy var lblStatus: UILabel = {
        let lbl = UILabel()
        lbl.textColor = R.color.greenTextColor()
        lbl.font = .boldSystemFont(ofSize: LocalConstants.statusFontSize)
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
    
    func fill(image: UIImage?, name: String?, status: String?) {
        vImage.image = image
        lblName.text = name
        lblStatus.text = status
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        contentView.backgroundColor = R.color.screenColor()
        
        contentView.addSubviews(vImage,
                                lblName,
                                lblStatus)
    }
    
    private func setupConstraints() {
        vImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.size.equalTo(LocalConstants.imageSize)
        }
        
        lblName.snp.makeConstraints {
            $0.top.equalTo(vImage.snp.bottom).inset(-Paddings.large)
            $0.centerX.equalToSuperview()
        }
        lblStatus.snp.makeConstraints {
            $0.top.equalTo(lblName.snp.bottom).offset(Paddings.small)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
