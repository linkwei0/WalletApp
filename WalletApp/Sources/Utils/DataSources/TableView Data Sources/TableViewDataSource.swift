//
//  TableViewDataSource.swift
//  WalletApp
//

import UIKit

protocol TableViewDataSourceDelegate: AnyObject {
  func tableViewDataSource(_ dateSource: TableViewDataSource, heightForHeaderInSection section: Int) -> CGFloat?
  func tableViewDataSource(_ dateSource: TableViewDataSource, heightForFooterInSection section: Int) -> CGFloat?
}

class TableViewDataSource: NSObject {
  weak var delegate: TableViewDataSourceDelegate?
  
  private var tableView: UITableView?
  private var viewModel: TableViewModel?
  
  func setup(tableView: UITableView, viewModel: TableViewModel) {
    self.tableView = tableView
    self.viewModel = viewModel
    
    tableView.dataSource = self
    tableView.delegate = self
    tableView.reloadData()
  }
  
  func update(with viewModel: TableViewModel) {
    self.viewModel = viewModel
    tableView?.reloadData()
  }
}

// MARK: - UITableViewDataSource
extension TableViewDataSource: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel?.sectionViewModels.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel?.sectionViewModels[section].cellViewModels.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cellViewModel = viewModel?.sectionViewModels[indexPath.section]
      .cellViewModels[indexPath.row] else { return UITableViewCell() }
    let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.tableReuseIdentifier, for: indexPath)
    (cell as? TableCell)?.configure(with: cellViewModel)
    return cell
  }
}

// MARK: - UITableViewDelegate
extension TableViewDataSource: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel?.sectionViewModels[indexPath.section].cellViewModels[indexPath.row].select(indexPath: indexPath)
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let headerViewModel = viewModel?.sectionViewModels[section].headerViewModel else { return nil }
    let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerViewModel.tableReuseIdentifier)
    (headerView as? TableHeaderView)?.configure(with: headerViewModel)
    return headerView
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    delegate?.tableViewDataSource(self, heightForHeaderInSection: section) ?? 0
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    guard let footerViewModel = viewModel?.sectionViewModels[section].footerViewModel else { return nil }
    let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: footerViewModel.tableReuseIdentifier)
    (footerView as? TableFooterView)?.configure(with: footerViewModel)
    return footerView
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return delegate?.tableViewDataSource(self, heightForFooterInSection: section) ?? 0
  }
}
