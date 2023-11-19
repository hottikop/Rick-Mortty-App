import UIKit
import SnapKit

class CardCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private lazy var imageView: UIImageView? = {
        let img = UIImageView()
        img.layer.cornerRadius = 10
        img.layer.masksToBounds = true
     
        return img
    }()
    
    private lazy var nameLabel: UILabel? = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = .boldSystemFont(ofSize: 17)
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
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
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = UIColor(named: Constants.Colors.cardColor)
        contentView.addSubview(imageView ?? UIImageView(image: .checkmark))
        contentView.addSubview(nameLabel ?? UILabel())
    }
    
    private func setupConstraints() {
        guard let imageView, let nameLabel else { return }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(contentView.frame.height * 0.05)
            make.trailing.equalToSuperview().inset(contentView.frame.height * 0.05)
            make.leading.equalToSuperview().offset(contentView.frame.width * 0.05)
            make.bottom.equalToSuperview().inset(contentView.frame.height * 0.26)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(contentView.frame.height * 0.81)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().inset(contentView.frame.height * 0.07)
        }
    }
    
    func fill(with image: UIImage?, name: String?) {
        imageView?.image = image
        nameLabel?.text = name
    }
}
