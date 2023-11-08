//
//  UIView+Gradient.swift
//  WalletApp
//
//  Created by Артём Бацанов on 07.11.2023.
//

import UIKit

extension UIView {
  func applyGradient(startColor: UIColor, endColor: UIColor) {
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    gradientLayer.frame = bounds
    
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
    
    layer.insertSublayer(gradientLayer, at: 0)
    
    layer.cornerRadius = 16
    layer.borderWidth = 1.0
    layer.borderColor = UIColor.baseBlack.cgColor
    clipsToBounds = true
  }
}
