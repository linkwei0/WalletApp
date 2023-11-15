//
//  WalletEditViewController.swift
//  WalletApp
//
//  Created by Артём Бацанов on 08.11.2023.
//

import UIKit

class WalletEditViewController: BaseViewController {
  // MARK: - Properties
  private var dataSource: SimpleTableViewDataSoruce<(CreateWalletCellViewModelProtocol & UpdateWalletCellViewModelProtocol)>?
  
  private let tableView = UITableView()
  private let saveButton = UIButton(type: .system)
  
  private let viewModel: WalletEditViewModel
  
  // MARK: - Init
  init(viewModel: WalletEditViewModel) {
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
    setupBindables()
    viewModel.viewIsReady()
  }
  
  // MARK: - Setup
  private func setup() {
    setupTableView()
    setupSaveButton()
  }
  
  private func setupTableView() {
    view.addSubview(tableView)
    tableView.rowHeight = 110
    tableView.register(CreateWalletCell.self, forCellReuseIdentifier: CreateWalletCell.reuseIdentifiable)
    tableView.separatorStyle = .none
    tableView.snp.makeConstraints { make in
      make.top.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  private func setupSaveButton() {
    view.addSubview(saveButton)
    saveButton.setTitle("Сохранить изменения", for: .normal)
    saveButton.setTitleColor(.baseWhite, for: .normal)
    saveButton.titleLabel?.font = UIFont.bodyBold ?? .boldSystemFont(ofSize: 16)
    saveButton.layer.cornerRadius = 12
    saveButton.backgroundColor = .accent
    saveButton.layer.borderWidth = 2.0
    saveButton.layer.borderColor = UIColor.accentDark.cgColor
    saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    saveButton.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(16)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-6)
      make.height.equalTo(50)
    }
  }
  
  // MARK: - Actions
  @objc private func didTapSaveButton() {
    viewModel.saveWallet()
  }
  
  // MARK: - Private methods
  private func updateTableView() {
    dataSource = SimpleTableViewDataSoruce.make(for: viewModel.cellViewModels)
    tableView.dataSource = dataSource
    tableView.reloadData()
  }
  
  // MARK: - Bindables
  private func setupBindables() {
    viewModel.onDidUpdate = { [weak self] in
      self?.updateTableView()
    }
  }
}
