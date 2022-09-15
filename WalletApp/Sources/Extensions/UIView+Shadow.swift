//
//  UIView+Shadow.swift
//  WalletApp
//

import UIKit

extension UIView {
  func addShadow(offset: CGSize, radius: CGFloat, color: UIColor = .zeroBlack, opacity: Float = 1) {
    layer.shadowOffset = offset
    layer.shadowRadius = radius
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
  }
}
