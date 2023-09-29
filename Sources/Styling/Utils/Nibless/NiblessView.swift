//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 28.04.2023.
//

import UIKit

/// `NiblessView` is a `UIView` subclass that avoids nib and storyboard initialization.
/// This class is ideal for views that are set up programmatically.
open class NiblessView: UIView {

  public override init(frame: CGRect) {
    super.init(frame: frame)
  }

  @available(*, unavailable,
  message: "Loading this view from a nib is unsupported in favor of initializer dependency injection."
  )

  public required init?(coder aDecoder: NSCoder) {
    fatalError("Loading this view from a nib is unsupported in favor of initializer dependency injection.")
  }
}
