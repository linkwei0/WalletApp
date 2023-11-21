//
//  CreateBudgetViewController.swift
//  WalletApp
//
//  Created by Артём Бацанов on 15.11.2023.
//

import UIKit

class CreateBudgetViewController: BaseViewController {
  // MARK: - Properties
  private let tableView = UITableView()
  private let createButton = UIButton(type: .system)
  
  private let dataSource = TableViewDataSource()
  
  private let viewModel: CreateBudgetViewModel
  
  // MARK: - Init
  init(viewModel: CreateBudgetViewModel) {
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
    setupCreateButton()
  }
  
  private func setupTableView() {
    view.addSubview(tableView)
    tableView.rowHeight = 80
    tableView.separatorStyle = .none
    tableView.register(CreateBudgetCell.self, forCellReuseIdentifier: CreateBudgetCell.reuseIdentifiable)
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    dataSource.setup(tableView: tableView, viewModel: viewModel)
  }
  
  private func setupCreateButton() {
    view.addSubview(createButton)
    createButton.setTitle("Создать бюджет", for: .normal)
    createButton.setTitleColor(.baseWhite, for: .normal)
    createButton.titleLabel?.font = UIFont.bodyBold ?? .boldSystemFont(ofSize: 16)
    createButton.layer.cornerRadius = 12
    createButton.backgroundColor = .accent
    createButton.layer.borderWidth = 2.0
    createButton.layer.borderColor = UIColor.accentDark.cgColor
    createButton.addTarget(self, action: #selector(didTapCreateButton), for: .touchUpInside)
    createButton.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(16)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-6)
      make.height.equalTo(50)
    }
  }
  
  // MARK: - Actions
  @objc private func didTapCreateButton() {
    print("Create new budget!")
  }
  
  // MARK: - Private methods
  private func updateTableView() {
    tableView.reloadData()
  }
  
  private func updateRow(at indexPath: IndexPath) {
    self.tableView.reloadRows(at: [indexPath], with: .none)
  }
  
  deinit {
    print("VC")
  }
  
  private func showCalculationModelView() {
    let modalViewController = CalculationModalViewController(viewModel: viewModel.calculationModalViewModel)
    modalViewController.modalPresentationStyle = .overCurrentContext
    present(modalViewController, animated: false)
  }
  
  // MARK: - Bindables
  private func setupBindables() {
    viewModel.onNeedsUpdate = { [weak self] in
      self?.updateTableView()
    }
    viewModel.onNeedsShowCalculationModalView = { [weak self] in
      self?.showCalculationModelView()
    }
    viewModel.onNeedsUpdateRow = { [weak self] indexPath in
      DispatchQueue.main.async {
        self?.updateRow(at: indexPath)
      }
    }
  }
}
