//
//  OperationEditViewController.swift
//  WalletApp
//
//  Created by Артём Бацанов on 31.10.2023.
//

import UIKit

class OperationEditViewController: BaseViewController {
  // MARK: - Properties
  private var dataSource: SimpleTableViewDataSoruce<OperationEditCellViewModelProtocols>?
  
  private let tableView = UITableView()
  private let editButton = UIButton(type: .system)
  
  let viewModel: OperationEditViewModel
  
  // MARK: - Init
  init(viewModel: OperationEditViewModel) {
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
  }
  
  // MARK: - Setup
  private func setup() {
    setupTableView()
    setupEditButton()
  }
  
  private func setupTableView() {
    view.addSubview(tableView)
    tableView.separatorStyle = .none
    tableView.bounces = false
    tableView.estimatedRowHeight = 50
    tableView.rowHeight = UITableView.automaticDimension
    tableView.register(OperationEditCell.self, forCellReuseIdentifier: OperationEditCell.reuseIdentifiable)
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    dataSource = SimpleTableViewDataSoruce.make(for: viewModel.cellViewModels)
    tableView.dataSource = dataSource
    tableView.delegate = self
    tableView.reloadData()
  }
  
  private func setupEditButton() {
    view.addSubview(editButton)
    editButton.setTitle(R.string.operationEdit.operationEditButtonEdit(), for: .normal)
    editButton.setTitleColor(.baseWhite, for: .normal)
    editButton.titleLabel?.font = UIFont.bodyBold ?? .boldSystemFont(ofSize: 16)
    editButton.layer.cornerRadius = 12
    editButton.backgroundColor = .accent
    editButton.layer.borderWidth = 2.0
    editButton.layer.borderColor = UIColor.accentDark.cgColor
    editButton.addTarget(self, action: #selector(didTapEditOperationButton), for: .touchUpInside)
    editButton.snp.makeConstraints { make in
      editButton.snp.makeConstraints { make in
        make.leading.trailing.equalToSuperview().inset(16)
        make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        make.height.equalTo(60)
      }
    }
  }
  
  // MARK: - Private methods
  private func reloadDataSource() {
    dataSource = SimpleTableViewDataSoruce.make(for: viewModel.cellViewModels)
    tableView.dataSource = dataSource
    tableView.reloadData()
  }
  
  // MARK: - Actions
  @objc private func didTapEditOperationButton() {
    viewModel.didTapEditOperation()
  }
  
  // MARK: - Bindables
  private func setupBindables() {
    viewModel.onNeedsToUpdateDataSource = { [weak self] in
      self?.reloadDataSource()
    }
  }
}

// MARK: - UITableViewDelegate
extension OperationEditViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.didSelectRow(at: indexPath.row)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return indexPath.row == 2 ? 180 : 80
  }
}
