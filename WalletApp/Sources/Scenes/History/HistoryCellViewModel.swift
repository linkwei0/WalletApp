//
//  HistoryCellViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 20.06.2023.
//

import UIKit

protocol HistoryCellViewModelProtocol {
  var title: String { get }
  var tintColor: UIColor { get }
  var date: Date { get }
}

class HistoryCellViewModel: HistoryCellViewModelProtocol {
  var title: String
  var date: Date
  
  var tintColor: UIColor {
    return UIColor.baseWhite
  }
  
  init(_ history: History) {
    self.title = history.title
    self.date = history.date
  }
}
