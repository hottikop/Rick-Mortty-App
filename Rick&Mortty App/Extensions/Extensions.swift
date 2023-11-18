import UIKit

extension UITableViewCell {
    static var reuseId: String {
        let className = String(describing: self)
        return className + "Id"
    }
}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: T.reuseId, for: indexPath) as? T ?? T()
    }
    
    func register(_ cellType: UITableViewCell.Type) {
        register(cellType, forCellReuseIdentifier: cellType.reuseId)
    }
}

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Iterator.Element? {
        get { startIndex <= index && index < endIndex ? self[index] : nil }
    }
}

extension UICollectionViewCell {
    static var reuseId: String {
        let className = String(describing: self)
        return className + "Id"
    }
}

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: T.reuseId, for: indexPath) as? T ?? T()
    }
    
    func register(_ cellType: UICollectionViewCell.Type) {
        register(cellType, forCellWithReuseIdentifier: cellType.reuseId)
    }
}
