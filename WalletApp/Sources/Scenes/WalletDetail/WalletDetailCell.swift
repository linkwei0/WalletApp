//
//  TestDetailCell.swift
//  WalletApp
//
//  Created by Артём Бацанов on 28.11.2023.
//

import UIKit

class WalletDetailCell: UITableViewCell, TableCell {
  // MARK: - Properties
  private var viewModel: WalletDetailCellViewModel? {
    didSet {
      reloadTableView()
    }
  }

  private let containerView = UIView()
  private let stackView = UIStackView()
  private let separatorLine = UIView()
  private let headerStackView = UIStackView()
  private let dateTypeLabel = Label(textStyle: .bodyBold)
  private let amountOfDayLabel = Label(textStyle: .bodyBold)
  private let operationsTableView = UITableView(frame: .zero, style: .grouped)
  private let bottomStackView = UIStackView()
  private let showMoreBottomButton = UIButton(type: .system)
  
  private let dataSource = TableViewDataSource()
  
  private let minimumContainerViewHeight = 90
  private let rowHeight: CGFloat = 44
  
  // MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  // MARK: - Configure
  func configure(with viewModel: TableCellViewModel) {
    guard let viewModel = viewModel as? WalletDetailCellViewModel else { return }
    self.viewModel = viewModel
    
    dateTypeLabel.text = viewModel.date
    amountOfDayLabel.text = viewModel.amountOfDay
    showMoreBottomButton.setTitle(viewModel.moreButtonTitle, for: .normal)
    
    let numberOfRows = viewModel.numberOfRowsInSection(section: 0)
    containerView.snp.remakeConstraints { make in
      make.top.bottom.equalToSuperview().inset(4)
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(minimumContainerViewHeight + (numberOfRows * Int(rowHeight))).priority(999)
    }
  }
  
  // MARK: - Setup
  private func setup() {
    setupBackground()
    setupContainerView()
    setupStackView()
    setupHeaderStackView()
    setupSeparatorLine()
    setupHeaderLabel()
    setupAmountLabel()
    setupTableView()
  }
    
  private func setupBackground() {
    backgroundColor = .clear
    selectionStyle = .none
  }
  
  private func setupContainerView() {
    contentView.addSubview(containerView)
    containerView.backgroundColor = .baseWhite
    containerView.layer.cornerRadius = 16
    containerView.addShadow(offset: CGSize(width: 0, height: 12), radius: 24, color: .baseBlack, opacity: 0.15)
    containerView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(4)
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(minimumContainerViewHeight)
    }
  }
  
  private func setupStackView() {
    containerView.addSubview(stackView)
    stackView.axis = .vertical
    stackView.spacing = 4
    stackView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(6)
      make.height.equalTo(40)
      make.leading.trailing.equalToSuperview().inset(12)
    }
  }
  
  private func setupHeaderStackView() {
    stackView.addArrangedSubview(headerStackView)
    headerStackView.axis = .horizontal
    headerStackView.spacing = 12
    headerStackView.distribution = .fillEqually
  }
  
  private func setupHeaderLabel() {
    headerStackView.addArrangedSubview(dateTypeLabel)
    dateTypeLabel.textColor = .baseBlack
    dateTypeLabel.textAlignment = .left
    dateTypeLabel.numberOfLines = 0
  }
  
  private func setupAmountLabel() {
    headerStackView.addArrangedSubview(amountOfDayLabel)
    amountOfDayLabel.textColor = .baseBlack
    amountOfDayLabel.textAlignment = .right
    amountOfDayLabel.numberOfLines = 0
  }
  
  private func setupSeparatorLine() {
    stackView.addArrangedSubview(separatorLine)
    separatorLine.backgroundColor = .shade2
    separatorLine.snp.makeConstraints { make in
      make.height.equalTo(0.5)
    }
  }
  
  private func setupTableView() {
    containerView.addSubview(operationsTableView)
    operationsTableView.rowHeight = rowHeight
    operationsTableView.backgroundColor = .clear
    operationsTableView.separatorStyle = .none
    operationsTableView.showsVerticalScrollIndicator = false
    operationsTableView.register(OperationItemCell.self, forCellReuseIdentifier: OperationItemCell.reuseIdentifiable)
    operationsTableView.snp.makeConstraints { make in
      make.top.equalTo(stackView.snp.bottom).offset(2)
      make.leading.trailing.equalToSuperview()
      make.bottom.equalToSuperview().offset(16)
    }
    
    operationsTableView.register(OperationDefaultFooterView.self, 
                                 forHeaderFooterViewReuseIdentifier: OperationDefaultFooterView.reuseIdentifiable)
    dataSource.delegate = self
  }
  
  // MARK: - Private methods
  private func reloadTableView() {
    guard let viewModel = viewModel else { return }
    dataSource.setup(tableView: operationsTableView, viewModel: viewModel)
  }
}

// MARK: - TableViewDataSourceDelegate
extension WalletDetailCell: TableViewDataSourceDelegate {
  func tableViewDataSource(_ dateSource: TableViewDataSource, heightForHeaderInSection section: Int) -> CGFloat? {
    return 0
  }
  
  func tableViewDataSource(_ dateSource: TableViewDataSource, heightForFooterInSection section: Int) -> CGFloat? {
    return 35
  }
}
