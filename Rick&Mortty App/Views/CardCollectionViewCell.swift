import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private lazy var imageView: UIImageView? = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 10
        img.frame = CGRect(x: 0, y: 0, width: 140, height: 140)
        return img
    }()
    
    private lazy var nameLabel: UILabel? = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        lbl.frame = CGRect(x: 0, y: 0, width: 99, height: 22)
        lbl.font = .boldSystemFont(ofSize: 17)
        return lbl
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setupView() {
        contentView.backgroundColor = UIColor(named: Constants.Colors.cardColor)
        contentView.addSubview(imageView ?? UIImageView(image: .checkmark))
        contentView.addSubview(nameLabel ?? UILabel())
    }
    
    private func setupConstraints() {
        guard let imageView, let nameLabel else { return }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 140)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 22),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func fill(with image: UIImage?, name: String?) {
        imageView?.image = image
        nameLabel?.text = name
        }
}
