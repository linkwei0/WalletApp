////
////  TestDetailViewController.swift
////  WalletApp
////
////  Created by Артём Бацанов on 28.11.2023.
////
//
//import UIKit
//
//class TestDetailViewController: BaseViewController {
//  // MARK: - Properties
//  private let tableView = UITableView()
//  private let bottomBarView: WalletBottomBarView
//  
//  private let dataSource = TableViewDataSource()
//  
//  private let viewModel: TestDetailViewModel
//  
//  // MARK: - Init
//  init(viewModel: TestDetailViewModel) {
//    self.viewModel = viewModel
//    self.bottomBarView = WalletBottomBarView(configuration: viewModel.bottomBarConfiguration)
//    super.init(nibName: nil, bundle: nil)
//  }
//  
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//  
//  // MARK: - Lifecycle
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    setup()
//    setupBindables()
//    viewModel.viewIsReady()
//  }
//  
//  // MARK: - Setup
//  private func setup() {
//    setupBackground()
//    setupTableView()
//    setupBottomBarView()
//  }
//  
//  private func setupBackground() {
//    view.backgroundColor = .systemGroupedBackground
//  }
//  
//  private func setupTableView() {
//    view.addSubview(tableView)
//    tableView.separatorStyle = .none
//    tableView.showsVerticalScrollIndicator = false
////    tableView.estimatedRowHeight = 200
////    tableView.rowHeight = UITableView.automaticDimension
//    tableView.rowHeight = 215
//    tableView.backgroundColor = .clear
//    tableView.register(WalletDetailCell.self, forCellReuseIdentifier: WalletDetailCell.reuseIdentifiable)
//    tableView.snp.makeConstraints { make in
//      make.edges.equalToSuperview()
//    }
//    dataSource.setup(tableView: tableView, viewModel: viewModel)
//  }
//  
//  private func setupBottomBarView() {
//    view.addSubview(bottomBarView)
//    bottomBarView.onDidSelectItem = { [weak self] itemType in
//      self?.viewModel.didSelectBottomBarItem(itemType)
//    }
//    bottomBarView.snp.makeConstraints { make in
//      make.leading.trailing.equalToSuperview().inset(16)
//      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-6)
//      make.height.equalTo(50)
//    }
//  }
//  
//  // MARK: - Private methods
//  private func reloadTableView() {
//    tableView.reloadData()
//  }
//  
//  // MARK: - Bindables
//  private func setupBindables() {
//    viewModel.viewState.bind { [weak self] state in
//      DispatchQueue.main.async {
//        self?.reloadTableView()
//      }
//    }
//  }
//}
