//
//  SimpleTableViewDataSource.swift
//  WalletApp
//
//  Created by Артём Бацанов on 20.06.2023.
//

import UIKit

class SimpleTableViewDataSoruce<ViewModel>: NSObject, UITableViewDataSource {
  typealias CellConfigurator = (ViewModel, UITableViewCell) -> Void
  
  private let reuseIdentifier: String
  private let cellViewModels: [ViewModel]
  private let cellConfigurator: CellConfigurator
  
  init(reuseIdentifier: String, cellViewModels: [ViewModel], cellConfigurator: @escaping CellConfigurator) {
    self.reuseIdentifier = reuseIdentifier
    self.cellViewModels = cellViewModels
    self.cellConfigurator = cellConfigurator
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cellViewModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
    let viewModel = cellViewModels[indexPath.row]
    cellConfigurator(viewModel, cell)
    return cell
  }
}

extension SimpleTableViewDataSoruce where ViewModel == HistoryCellViewModelProtocol {
  static func make(for cellViewModels: [ViewModel],
                   reuseIdentifier: String = HistoryCell.reuseIdentifiable) -> SimpleTableViewDataSoruce {
    return SimpleTableViewDataSoruce(reuseIdentifier: reuseIdentifier,
                                     cellViewModels: cellViewModels) { viewModel, cell in
      (cell as? HistoryCell)?.viewModel = viewModel
    }
  }
}
