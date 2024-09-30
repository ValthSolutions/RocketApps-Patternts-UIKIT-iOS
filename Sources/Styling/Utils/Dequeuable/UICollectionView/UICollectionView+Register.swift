import UIKit


extension UICollectionView {
    
    // MARK: - Register Reusable View
    public func registerReusableView<T: UICollectionReusableView>(viewType: T.Type) {
        let identifier = viewType.dequeuIdentifier
        register(viewType, forSupplementaryViewOfKind: identifier, withReuseIdentifier: identifier)
    }
    
    // MARK: - Register Cell
    public func registerCell<T: UICollectionViewCell>(cellType: T.Type) {
        let identifier = cellType.dequeuIdentifier
        register(cellType, forCellWithReuseIdentifier: identifier)
    }
    
    // MARK: - Dequeing
    public func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: type.dequeuIdentifier, for: indexPath) as! T
    }
    
    public func dequeueReusableSupplementaryView<T: UICollectionReusableView>(with type: T.Type, at indexPath: IndexPath) -> T {
        return self.dequeueReusableSupplementaryView(ofKind: type.dequeuIdentifier, withReuseIdentifier: type.dequeuIdentifier, for: indexPath) as! T
    }
}

extension UICollectionReusableView: Dequeuable { }
