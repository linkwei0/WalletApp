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
}

protocol TableHeaderView {
  func configure(with viewModel: TableHeaderViewModel)
}

protocol TableHeaderViewModel {
  var tableReuseIdentifier: String { get }
}

class TableSectionViewModel {
  let headerViewModel: TableHeaderViewModel?
  
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
  
  init(headerViewModel: TableHeaderViewModel? = nil) {
    self.headerViewModel = headerViewModel
  }
}

protocol TableViewModel {
  var sectionViewModels: [TableSectionViewModel] { get }
}
