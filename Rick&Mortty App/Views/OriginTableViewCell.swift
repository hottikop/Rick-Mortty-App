//
//  OriginTableViewCell.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 20.11.2023.
//

import UIKit
import SnapKit

final class OriginTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    
    enum LocalConstants {
        static let planetFontSize: CGFloat = 13
        static let planetValueFontSize: CGFloat = 17
        static let planetTitle = "Planet"
    }
    
    // MARK: - Subviews
    
    private lazy var vInner: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = CornerRadius.medium
        view.backgroundColor = R.color.cardColor()
        return view
    }()
    
    private lazy var vImageInner: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = CornerRadius.small
        view.backgroundColor = R.color.blackElementsColor()
        return view
    }()
    
    private lazy var vImage: UIImageView = {
        let img = UIImageView()
        img.image = R.image.planetImage()
        return img
    }()
    
    private lazy var lblPlanet: UILabel = {
        let lbl = UILabel()
        lbl.text = LocalConstants.planetTitle
        lbl.textColor = R.color.greenTextColor()
        lbl.font = .boldSystemFont(ofSize: LocalConstants.planetFontSize)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private lazy var lblPlanetValue: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = .boldSystemFont(ofSize: LocalConstants.planetValueFontSize)
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
                                vImageInner,
                                vImage,
                                lblPlanet,
                                lblPlanetValue)
    }
    
    private func setupConstraints() {
        vInner.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Paddings.small)
            $0.horizontalEdges.equalToSuperview().inset(Paddings.large)
            $0.bottom.equalToSuperview().inset(Paddings.large)
        }
        
        vImageInner.snp.makeConstraints {
            $0.top.bottom.equalTo(vInner).inset(Paddings.small)
            $0.leading.equalTo(vInner).inset(Paddings.small)
        }
        
        vImage.snp.makeConstraints {
            $0.edges.equalTo(vImageInner).inset(Paddings.large)
        }
        
        lblPlanetValue.snp.makeConstraints {
            $0.top.equalTo(vInner).inset(Paddings.medium)
            $0.leading.equalTo(vImageInner.snp.trailing).inset(-Paddings.medium)
        }
        
        lblPlanet.snp.makeConstraints {
            $0.top.equalTo(lblPlanetValue).inset(Paddings.small)
            $0.leading.equalTo(vImageInner.snp.trailing).inset(-Paddings.medium)
            $0.bottom.equalTo(vInner)
        }
    }
    
    func fill(origin: String?) {
        lblPlanetValue.text = origin
    }
}
