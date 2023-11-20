//
//  CreateBudgetCell.swift
//  WalletApp
//
//  Created by Артём Бацанов on 16.11.2023.
//

import UIKit

class CreateBudgetCell: UITableViewCell, TableCell {
  // MARK: - Properties
  private let containerView = UIView()
  private let amountContainerView = UIView()
  private let budgetAmountLabel = Label(textStyle: .header1)
  private let titleLabel = Label(textStyle: .bodyBold)
  
  private var viewModel: CreateBudgetCellViewModel?
  
  // MARK: - Lifecycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
    setupBindables()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
    setupBindables()
  }
  
  // MARK: - Configure
  func configure(with viewModel: TableCellViewModel) {
    guard let viewModel = viewModel as? CreateBudgetCellViewModel else { return }
    self.viewModel = viewModel
    containerView.isHidden = viewModel.isHiddenContainer
    amountContainerView.isHidden = !viewModel.isHiddenContainer
    budgetAmountLabel.text = viewModel.amount
    titleLabel.text = viewModel.title
  }
  
  // MARK: - Setup
  private func setup() {
    selectionStyle = .none
    setupContainerView()
    setupAmountContainerView()
    setupBudgetAmountLabel()
    setupTitleLabel()
  }
  
  private func setupContainerView() {
    contentView.addSubview(containerView)
    containerView.layer.cornerRadius = 12
    containerView.layer.borderWidth = 1.0
    containerView.layer.borderColor = UIColor.accent.cgColor
    containerView.isHidden = true
    containerView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(8)
      make.leading.trailing.equalToSuperview().inset(16)
    }
  }
  
  private func setupAmountContainerView() {
    contentView.addSubview(amountContainerView)
    amountContainerView.layer.cornerRadius = 12
    amountContainerView.layer.borderWidth = 1.0
    amountContainerView.backgroundColor = .accent
    amountContainerView.isHidden = true
    amountContainerView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(8)
      make.leading.trailing.equalToSuperview().inset(16)
    }
  }
  
  private func setupBudgetAmountLabel() {
    amountContainerView.addSubview(budgetAmountLabel)
//    budgetAmountLabel.text = "0"
    budgetAmountLabel.textColor = .baseWhite
    budgetAmountLabel.textAlignment = .right
    budgetAmountLabel.snp.makeConstraints { make in
      make.top.bottom.leading.equalToSuperview()
      make.trailing.equalToSuperview().inset(16)
    }
  }
  
  private func setupTitleLabel() {
    containerView.addSubview(titleLabel)
    titleLabel.text = "Choose period of date"
    titleLabel.textColor = .baseBlack
    titleLabel.textAlignment = .left
    titleLabel.snp.makeConstraints { make in
      make.top.bottom.trailing.equalToSuperview()
      make.leading.equalToSuperview().inset(16)
    }
  }
  
  private func setupBindables() {
//    viewModel?.budgetAmount.bind { amount in
//      self.budgetAmountLabel.text = amount
//    }
  }
}
