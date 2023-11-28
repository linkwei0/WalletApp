//
//  TableViewDataSourceProtocols.swift
//  WalletApp
//

import Foundation

protocol TableCell {
  func configure(with viewModel: TableCellViewModel)
}

protocol TableCellViewModel {
  var tableReuseIdentifier: String { get }
  func select(indexPath: IndexPath)
}

extension TableCellViewModel {
  func select(indexPath: IndexPath) {}
}

protocol TableHeaderView {
  func configure(with viewModel: TableHeaderViewModel)
}

protocol TableFooterView {
  func configure(with viewModel: TableFooterViewModel)
}

protocol TableHeaderViewModel {
  var tableReuseIdentifier: String { get }
}

protocol TableFooterViewModel {
  var tableReuseIdentifier: String { get }
}

protocol TableViewModel {
  var sectionViewModels: [TableSectionViewModel] { get }
}
