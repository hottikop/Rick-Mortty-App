import UIKit
import SnapKit

final class CardCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    enum LocalConstants {
        static let labelFontSize: CGFloat = 17
        static let imageSize = 140
    }
    
    // MARK: - Subviews
    
    private lazy var vInner: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = CornerRadius.medium
        view.backgroundColor = R.color.cardColor()
        
        return view
    }()
    
    private lazy var vImage: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = CornerRadius.small
        img.layer.masksToBounds = true
        return img
    }()
    
    private lazy var lblName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = .boldSystemFont(ofSize: LocalConstants.labelFontSize)
        lbl.textAlignment = .center
        return lbl
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func fill(name: String?) {
        lblName.text = name
    }
    
    func fillImage(image: UIImage?) {
        vImage.image = image
    }
    
    // MARK: - Private Methods
    
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
            $0.top.equalTo(vInner.snp.top).inset(Paddings.small)
            $0.centerX.equalTo(vInner)
            $0.size.equalTo(LocalConstants.imageSize)
        }

        lblName.snp.makeConstraints {
            $0.top.equalTo(vImage.snp.bottom).inset(-Paddings.medium)
            $0.centerX.equalTo(vInner)
            $0.horizontalEdges.equalTo(vInner)
            $0.bottom.equalTo(vInner).inset(Paddings.medium)
        }
    }
}
