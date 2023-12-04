//
//  CreateWalletViewController.swift
//  WalletApp
//

import UIKit

class CreateWalletViewController: BaseViewController {
  // MARK: - Properties
  private var dataSource: SimpleTableViewDataSoruce<(CreateWalletCellViewModelProtocol & UpdateWalletCellViewModelProtocol)>?
  
  private let createWalletFormTableView = UITableView()
  private let createWalletButton = UIButton(type: .system)
  
  let viewModel: CreateWalletViewModel
  
  // MARK: - Init
  init(viewModel: CreateWalletViewModel) {
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
  
  // MARK: - Setups
  private func setup() {
    setupTapGestureRecognizer()
    setupFormTableView()
    setupCreateWalletButton()
  }
  
  private func setupTapGestureRecognizer() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(didTapOnView))
    view.addGestureRecognizer(tap)
  }
  
  private func setupFormTableView() {
    view.addSubview(createWalletFormTableView)
    createWalletFormTableView.rowHeight = 110
    createWalletFormTableView.register(CreateWalletCell.self, forCellReuseIdentifier: CreateWalletCell.reuseIdentifiable)
    createWalletFormTableView.separatorStyle = .none
    
    dataSource = SimpleTableViewDataSoruce.make(for: viewModel.cellViewModels)
    createWalletFormTableView.dataSource = dataSource
    
    createWalletFormTableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  private func setupCreateWalletButton() {
    view.addSubview(createWalletButton)
    createWalletButton.setTitle(R.string.createWallet.createWalletButtonCreateTitle(), for: .normal)
    createWalletButton.setTitleColor(.baseWhite, for: .normal)
    createWalletButton.titleLabel?.font = UIFont.bodyBold ?? .boldSystemFont(ofSize: 16)
    createWalletButton.layer.cornerRadius = 12
    createWalletButton.backgroundColor = .accent
    createWalletButton.layer.borderWidth = 2.0
    createWalletButton.layer.borderColor = UIColor.accentDark.cgColor
    createWalletButton.addTarget(self, action: #selector(didTapCreateWalletButton), for: .touchUpInside)
    createWalletButton.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(16)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-6)
      make.height.equalTo(50)
    }
  }
  
  // MARK: - Actions
  @objc private func didTapCreateWalletButton() {
    viewModel.createNewWallet()
  }
  
  @objc private func didTapOnView() {
    view.endEditing(true)
  }
}
