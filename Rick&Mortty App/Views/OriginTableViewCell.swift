//
//  OriginTableViewCell.swift
//  Rick&Mortty App
//
//  Created by Максим Целигоров on 20.11.2023.
//

import UIKit
import SnapKit

final class OriginTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    private lazy var vInner: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 16
        view.backgroundColor = UIColor(named: Constants.Colors.cardColor)
        return view
    }()
    
    private lazy var vImageInner: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor(named: Constants.Colors.blackElementsColor)
        return view
    }()
    
    private lazy var vImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: Constants.Images.planetImage)
        return img
    }()
    
    private lazy var lblPlanet: UILabel = {
        let lbl = UILabel()
        lbl.text = "Planet"
        lbl.textColor = UIColor(named: Constants.Colors.greenText)
        lbl.font = .boldSystemFont(ofSize: 13)
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    private lazy var lblPlanetValue: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = .boldSystemFont(ofSize: 17)
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
        contentView.addSubviews(vInner,
                                vImageInner,
                                vImage,
                                lblPlanet,
                                lblPlanetValue)
    }
    
    private func setupConstraints() {
        vInner.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(24)
        }
        
        vImageInner.snp.makeConstraints {
            $0.top.bottom.equalTo(vInner).inset(8)
            $0.leading.equalTo(vInner).inset(8)
        }
        
        vImage.snp.makeConstraints {
            $0.edges.equalTo(vImageInner).inset(20)
        }
        
        lblPlanetValue.snp.makeConstraints {
            $0.top.equalTo(vInner).inset(16)
            $0.leading.equalTo(vImageInner.snp.trailing).inset(-16)
        }
        
        lblPlanet.snp.makeConstraints {
            $0.top.equalTo(lblPlanetValue).inset(8)
            $0.leading.equalTo(vImageInner.snp.trailing).inset(-16)
            $0.bottom.equalTo(vInner)
        }
    }
    
    func fill(origin: String?) {
        lblPlanetValue.text = origin
    }
}
