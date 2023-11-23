import UIKit
import SnapKit

final class CardCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private lazy var vInner: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 16
        view.backgroundColor = UIColor(named: Constants.Colors.cardColor)
        
        return view
    }()
    
    private lazy var vImage: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 10
        img.layer.masksToBounds = true
        return img
    }()
    
    private lazy var lblName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = .boldSystemFont(ofSize: 17)
        lbl.textAlignment = .center
        return lbl
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setupUI() {
        contentView.addSubviews(vInner,
                                vImage,
                                lblName)
    }
    
    private func setupConstraints() {
        vInner.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        vImage.snp.makeConstraints {
            $0.top.equalTo(vInner.snp.top).inset(8)
            $0.centerX.equalTo(vInner)
            $0.size.equalTo(140)
        }

        lblName.snp.makeConstraints {
            $0.top.equalTo(vImage.snp.bottom).inset(-16)
            $0.centerX.equalTo(vInner)
            $0.bottom.equalTo(vInner).inset(16)
        }
    }
    
    func fill(name: String?) {
        lblName.text = name
    }
    
    func fillImage(image: UIImage?) {
        vImage.image = image
    }
}
