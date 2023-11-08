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
  func select()
}

extension TableCellViewModel {
  func select() {}
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

class TableSectionViewModel {
  let headerViewModel: TableHeaderViewModel?
  let footerViewModel: TableFooterViewModel?
  
  private(set) var cellViewModels: [TableCellViewModel] = []
  
  func append(_ cellViewModel: TableCellViewModel) {
    cellViewModels.append(cellViewModel)
  }
  
  func append(cellViewModels: [TableCellViewModel]) {
    self.cellViewModels.append(contentsOf: cellViewModels)
  }
  
  func remove(at index: Int) {
    cellViewModels.remove(at: index)
  }
  
  init(headerViewModel: TableHeaderViewModel? = nil, footerViewModel: TableFooterViewModel? = nil) {
    self.headerViewModel = headerViewModel
    self.footerViewModel = footerViewModel
  }
}

protocol TableViewModel {
  var sectionViewModels: [TableSectionViewModel] { get }
}
