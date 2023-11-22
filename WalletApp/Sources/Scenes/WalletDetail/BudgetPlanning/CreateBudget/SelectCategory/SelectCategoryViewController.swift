//
//  SelectCategoryViewController.swift
//  WalletApp
//
//  Created by Артём Бацанов on 21.11.2023.
//

import UIKit

class SelectCategoryViewController: BaseViewController {
  // MARK: - Properties
  private var dataSource: SimpleTableViewDataSoruce<SelectCategoryCellViewModelProtocol>?
  
  private let tableView = UITableView()
  
  private let viewModel: SelectCategoryViewModel
  
  // MARK: - Init
  init(viewModel: SelectCategoryViewModel) {
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
    tableView.rowHeight = 80
    tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    tableView.separatorColor = .baseBlack
    tableView.register(SelectCategoryCell.self, forCellReuseIdentifier: SelectCategoryCell.reuseIdentifiable)
    tableView.delegate = self
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    dataSource = SimpleTableViewDataSoruce.make(for: viewModel.cellViewModels)
    tableView.dataSource = dataSource
  }
}

// MARK: - UITableViewDelegate
extension SelectCategoryViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.didSelectRow(at: indexPath)
  }
}
