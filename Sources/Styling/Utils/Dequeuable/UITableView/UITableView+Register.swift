import UIKit

extension UITableView {

  // MARK: - Register Cell
  public func registerCell<T: UITableViewCell>(cellType: T.Type) {
    let identifier = cellType.dequeuIdentifier
      register(cellType, forCellReuseIdentifier: identifier)
  }

  // MARK: - Dequeing
    
  public func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
      return self.dequeueReusableCell(withIdentifier: type.dequeuIdentifier, for: indexPath) as! T
  }
}

extension UITableViewCell: Dequeuable { }
