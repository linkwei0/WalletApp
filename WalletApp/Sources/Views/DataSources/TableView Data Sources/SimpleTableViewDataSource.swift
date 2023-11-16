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

// MARK: - OperationCellViewModelProtocol
extension SimpleTableViewDataSoruce where ViewModel == OperationCellViewModelProtocol {
  static func make(for cellViewModels: [ViewModel],
                   reuseIdentifier: String = OperationItemCell.reuseIdentifiable) -> SimpleTableViewDataSoruce {
    return SimpleTableViewDataSoruce(reuseIdentifier: reuseIdentifier,
                                     cellViewModels: cellViewModels) { viewModel, cell in
      guard let cell = (cell as? OperationItemCell) else { return }
      cell.configure(with: viewModel)
    }
  }
}

// MARK: - CreateWalletCellViewModelProtocol
extension SimpleTableViewDataSoruce where ViewModel == CreateWalletCellViewModelProtocol & UpdateWalletCellViewModelProtocol {
  static func make(for cellViewModels: [ViewModel],
                   reuseIdentifier: String = CreateWalletCell.reuseIdentifiable) -> SimpleTableViewDataSoruce {
    return SimpleTableViewDataSoruce(reuseIdentifier: reuseIdentifier,
                                     cellViewModels: cellViewModels) { viewModel, cell in
      guard let cell = (cell as? CreateWalletCell) else { return }
      cell.configure(with: viewModel)
    }
  }
}

// MARK: - WalletCellViewModelProtocol
extension SimpleTableViewDataSoruce where ViewModel == WalletCellViewModelProtocol {
  static func make(for cellViewModels: [ViewModel],
                   reuseIdentifier: String = WalletCell.reuseIdentifiable) -> SimpleTableViewDataSoruce {
    return SimpleTableViewDataSoruce(reuseIdentifier: reuseIdentifier,
                                     cellViewModels: cellViewModels) { viewModel, cell in
      guard let cell = (cell as? WalletCell) else { return }
      cell.configure(with: viewModel)
    }
  }
}

// MARK: - OperationEditCellViewModelProtocols
extension SimpleTableViewDataSoruce where ViewModel == OperationEditCellViewModelProtocols {
  static func make(for cellViewModels: [ViewModel],
                   reuseIdentifier: String = OperationEditCell.reuseIdentifiable) -> SimpleTableViewDataSoruce {
    return SimpleTableViewDataSoruce(reuseIdentifier: reuseIdentifier,
                                     cellViewModels: cellViewModels) { viewModel, cell in
      guard let cell = (cell as? OperationEditCell) else { return }
      cell.configure(with: viewModel)
    }
  }
}

// MARK: - CreateBudgetCellViewModelProtocol
extension SimpleTableViewDataSoruce where ViewModel == CreateBudgetCellViewModelProtocol {
  static func make(for cellViewModels: [ViewModel], 
                   reuseIdentifier: String = CreateBudgetCell.reuseIdentifiable) -> SimpleTableViewDataSoruce {
    return SimpleTableViewDataSoruce(reuseIdentifier: reuseIdentifier, cellViewModels: cellViewModels) { viewModel, cell in
      guard let cell = (cell as? CreateBudgetCell) else { return }
      cell.configure(with: viewModel)
    }
  }
}
