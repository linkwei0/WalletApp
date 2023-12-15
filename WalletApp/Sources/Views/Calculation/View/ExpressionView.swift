//
//  CustomCalculationView.swift
//  WalletApp
//

import UIKit

protocol CustomCalculationViewDelegate: AnyObject {
  func didTapClearButton(_ view: ExpressionView, text: String)
  func didTapAllClearButton(_ view: ExpressionView)
  func didTapCheckButton(_ view: ExpressionView, with value: String)
}

class ExpressionView: UIView {
  // MARK: - Propeties
  weak var delegate: CustomCalculationViewDelegate?
    
  private let stackView = UIStackView()
  private let tableView = UITableView(frame: .zero, style: .plain)
  private let containerView = UIView()
  private let signLabel = Label(textStyle: .header1)
  private let previousValueLabel = Label(textStyle: .header2)
  private let currentValueLabel = Label(textStyle: .header1)
  
  private let dataSource = TableViewDataSource()
  
  private let collectionType: CollectionType
  
  private let viewModel: ExpressionViewModel
  
  // MARK: - Init
  init(viewModel: ExpressionViewModel, collectionType: CollectionType) {
    self.viewModel = viewModel
    self.collectionType = collectionType
    super.init(frame: .zero)
    setup()
    bindToViewModel()
    viewModel.getOperations()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup
  private func setup() {
    setupBackground()
    setupOperationsTableView()
    setupContainerView()
    setupStackView()
    setupCurrentSignLabel()
    setupSupportingValueLabel()
    setupCurrentValueLabel()
  }
  
  private func setupBackground() {
    backgroundColor = .clear
  }
  
  private func setupOperationsTableView() {
    addSubview(tableView)
    tableView.separatorStyle = .none
    tableView.rowHeight = 30
    tableView.showsVerticalScrollIndicator = true
    tableView.backgroundColor = .clear
    tableView.register(OperationDateHeaderView.self,
                       forHeaderFooterViewReuseIdentifier: OperationDateHeaderView.reuseIdentifiable)
    tableView.register(OperationItemCell.self, forCellReuseIdentifier: OperationItemCell.reuseIdentifiable)
    tableView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(300)
    }
    dataSource.setup(tableView: tableView, viewModel: viewModel)
    dataSource.delegate = self
  }
  
  private func setupContainerView() {
    addSubview(containerView)
    containerView.backgroundColor = .shade2
    containerView.layer.cornerRadius = 12
    containerView.snp.makeConstraints { make in
      make.top.equalTo(tableView.snp.bottom).inset(4)
      make.leading.trailing.equalToSuperview().inset(12)
      make.bottom.equalToSuperview()
    }
  }
  
  private func setupStackView() {
    containerView.addSubview(stackView)
    stackView.axis = .horizontal
    stackView.spacing = 4
    stackView.distribution = .fillProportionally
    stackView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.leading.equalToSuperview().inset(8)
      make.width.equalTo(120)
    }
  }
  
  private func setupCurrentSignLabel() {
    stackView.addArrangedSubview(signLabel)
    signLabel.textColor = .baseWhite
    signLabel.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
    }
  }
  
  private func setupSupportingValueLabel() {
    stackView.addArrangedSubview(previousValueLabel)
    previousValueLabel.textColor = .baseWhite
    previousValueLabel.textAlignment = .left
    previousValueLabel.adjustsFontSizeToFitWidth = true
  }
  
  private func setupCurrentValueLabel() {
    containerView.addSubview(currentValueLabel)
    currentValueLabel.textColor = .baseWhite
    currentValueLabel.textAlignment = .right
    currentValueLabel.font = UIFont.header1?.withSize(45)
    currentValueLabel.clipsToBounds = true
    currentValueLabel.adjustsFontSizeToFitWidth = true
    currentValueLabel.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(4)
      make.trailing.equalToSuperview().inset(8)
    }
  }
  
  // MARK: - Private methods
  private func reloadTableView() {
    tableView.reloadData()
  }
  
  // MARK: - Bindables
  private func bindToViewModel() {
    viewModel.visibleCurrentValue.bind { [weak self] value in
      self?.currentValueLabel.text = value
    }
    
    viewModel.visiblePreviousValue.bind { [weak self] value in
      self?.previousValueLabel.text = value
    }
    
    viewModel.visibleSign.bind { [weak self] sign in
      self?.signLabel.text = sign
    }
    
    viewModel.onNeedsToUpdateTableView = { [weak self] in
      guard let strongSelf = self else { return }
      DispatchQueue.main.async {
        strongSelf.reloadTableView()
      }
    }
  }
}

// MARK: - TableViewDataSourceDelegate
extension ExpressionView: TableViewDataSourceDelegate {
  func tableViewDataSource(_ dateSource: TableViewDataSource, heightForHeaderInSection section: Int) -> CGFloat? {
    return 30
  }
  
  func tableViewDataSource(_ dateSource: TableViewDataSource, heightForFooterInSection section: Int) -> CGFloat? {
    return 0
  }
}
