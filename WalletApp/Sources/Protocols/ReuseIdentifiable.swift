//
//  ReuseIdentifiable.swift
//  WalletApp
//
//  Created by Артём Бацанов on 20.04.2023.
//

import UIKit

protocol ReuseIdentifiable {
  static var reuseIdentifiable: String { get }
}

extension ReuseIdentifiable where Self: UIView {
  static var reuseIdentifiable: String {
    String(describing: self)
  }
}

extension UITableViewCell: ReuseIdentifiable {}
extension UICollectionViewCell: ReuseIdentifiable {}
extension UITableViewHeaderFooterView: ReuseIdentifiable {}
