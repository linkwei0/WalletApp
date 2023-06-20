//
//  UIView+Corners.swift
//  WalletApp
//
//  Created by Артём Бацанов on 30.05.2023.
//

import UIKit

extension UIView {
  func cornerRadius(usingCorner corners: UIRectCorner, cornerRadius: CGSize) {
    let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: cornerRadius)
    
    let maskLayer = CAShapeLayer()
    maskLayer.path = path.cgPath
    maskLayer.lineWidth = 2.0
    maskLayer.strokeColor = UIColor.red.cgColor
    
    self.layer.mask = maskLayer
  }
}
