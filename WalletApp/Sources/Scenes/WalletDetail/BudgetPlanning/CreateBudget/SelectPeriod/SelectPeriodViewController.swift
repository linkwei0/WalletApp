//
//  SelectPeriodViewController.swift
//  WalletApp
//
//  Created by Артём Бацанов on 20.11.2023.
//

import UIKit

class SelectPeriodViewController: UIViewController {
  // MARK: - Properties
  private var dataSource: SimpleTableViewDataSoruce<SelectPeriodCellViewModelProtocol>?
  
  private let tableView = UITableView()
  
  private let viewModel: SelectPeriodViewModel
  
  // MARK: - Init
  init(viewModel: SelectPeriodViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  // MARK: - Setup
  private func setup() {
    setupTableView()
  }
  
  private func setupTableView() {
    view.addSubview(tableView)
    tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    tableView.rowHeight = 80
    tableView.separatorColor = .baseBlack
    tableView.delegate = self
    tableView.register(SelectPeriodCell.self, forCellReuseIdentifier: SelectPeriodCell.reuseIdentifiable)
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    dataSource = SimpleTableViewDataSoruce.make(for: viewModel.cellViewModels)
    tableView.dataSource = dataSource
  }
}

// MARK: - UITableViewDelegate
extension SelectPeriodViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.didSelectRow(at: indexPath)
  }
}
