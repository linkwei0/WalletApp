//
//  TableSectionViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 15.11.2023.
//

import Foundation

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
  
  func update(at index: Int, with cellViewModel: TableCellViewModel) {
    cellViewModels[index] = cellViewModel
  }
  
  func remove(at index: Int) {
    cellViewModels.remove(at: index)
  }
  
  init(headerViewModel: TableHeaderViewModel? = nil, footerViewModel: TableFooterViewModel? = nil) {
    self.headerViewModel = headerViewModel
    self.footerViewModel = footerViewModel
  }
}
