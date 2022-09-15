//
//  HighlightableButton.swift
//  WalletApp
//

import UIKit

class HighlightableButton: UIButton {
  var onHighlightStateDidChange: ((_ isHighlighted: Bool) -> Void)?
  
  override var isHighlighted: Bool {
    didSet {
      onHighlightStateDidChange?(isHighlighted)
    }
  }
}
