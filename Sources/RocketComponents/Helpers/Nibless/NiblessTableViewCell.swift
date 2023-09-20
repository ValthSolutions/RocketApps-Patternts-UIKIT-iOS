//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 28.04.2023.
//

import UIKit

/// `NiblessTableViewCell` is a `UITableViewCell` subclass that avoids nib and storyboard initialization.
/// Ideal for table view cells that are set up programmatically.
open class NiblessTableViewCell: UITableViewCell {

  public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }

  // MARK: - Restricted Init
  @available(*, unavailable,
  message: "Loading this view Cell from a nib is unsupported in favor of initializer dependency injection.")
  public required init?(coder: NSCoder) {
    fatalError("Loading this view Cell from a nib is unsupported in favor of initializer dependency injection.")
  }
}
