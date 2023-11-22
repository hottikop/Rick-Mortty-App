import UIKit
import SnapKit

final class CardCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private lazy var vImage: UIImageView? = {
        let img = UIImageView()
        img.layer.cornerRadius = 10
        img.layer.masksToBounds = true
        return img
    }()
    
    private lazy var lblName: UILabel? = {
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
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = UIColor(named: Constants.Colors.cardColor)
        contentView.addSubview(vImage ?? UIImageView(image: .checkmark))
        contentView.addSubview(lblName ?? UILabel())
    }
    
    private func setupConstraints() {
        guard let vImage, let lblName else { return }
        
        vImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(contentView.frame.height * 0.05)
            make.trailing.equalToSuperview().inset(contentView.frame.height * 0.05)
            make.leading.equalToSuperview().offset(contentView.frame.width * 0.05)
            make.bottom.equalToSuperview().inset(contentView.frame.height * 0.26)
        }
        lblName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(contentView.frame.height * 0.81)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().inset(contentView.frame.height * 0.07)
        }
    }
    
    func fill(name: String?) {
        lblName?.text = name
    }
    
    func fillImage(image: UIImage?) {
        vImage?.image = image
    }
}
