//
//  BudgetCell.swift
//  WalletApp
//
//  Created by Артём Бацанов on 21.11.2023.
//

import UIKit

class BudgetCell: UITableViewCell, TableCell {
  // MARK: - Properties
  private let containerView = UIView()
  private let stackView = UIStackView()
  private let periodTypeLabel = Label(textStyle: .header2)
  private let containerProgressView = UIView()
  private let progressView = UIView()
  private let bottomStackView = UIStackView()
  private let amountLabel = Label(textStyle: .bodyBold)
  private let categoryLabel = Label(textStyle: .body)
  
  // MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    containerView.applyGradient(startColor: .accentDark, endColor: .accentFaded)
  }
  
  // MARK: - Configure
  func configure(with viewModel: TableCellViewModel) {
    guard let viewModel = viewModel as? BudgetCellViewModel else { return }
    periodTypeLabel.text = viewModel.period
    categoryLabel.text = viewModel.category
    amountLabel.text = viewModel.amount
  }
  
  // MARK: - Setup
  private func setup() {
    selectionStyle = .none
    setupContainerView()
    setupStackView()
    setupPeriodTypeLabel()
    setupProgressView()
    setupBottomStackView()
    setupCategoryLabel()
    setupAmountLabel()
  }
  
  private func setupContainerView() {
    contentView.addSubview(containerView)
    containerView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(16)
      make.leading.trailing.equalToSuperview().inset(24)
    }
  }
  
  private func setupStackView() {
    containerView.addSubview(stackView)
    stackView.axis = .vertical
    stackView.spacing = 6
    stackView.distribution = .fill
    stackView.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(16)
    }
  }
  
  private func setupPeriodTypeLabel() {
    stackView.addArrangedSubview(periodTypeLabel)
    periodTypeLabel.text = "На месяц"
    periodTypeLabel.textColor = .baseWhite
    periodTypeLabel.textAlignment = .left
  }
  
  private func setupProgressView() {
    stackView.addArrangedSubview(containerProgressView)
    containerProgressView.backgroundColor = .shade2
    containerProgressView.layer.cornerRadius = 10
    containerProgressView.snp.makeConstraints { make in
      make.height.equalTo(20)
    }
    containerProgressView.addSubview(progressView)
    progressView.backgroundColor = .baseWhite
    progressView.layer.cornerRadius = 10
    progressView.snp.makeConstraints { make in
      make.top.bottom.leading.equalToSuperview()
      make.width.equalTo(200)
    }
  }
  
  private func setupBottomStackView() {
    stackView.addArrangedSubview(bottomStackView)
    bottomStackView.axis = .horizontal
    bottomStackView.spacing = 12
    bottomStackView.distribution = .fillEqually
  }
  
  private func setupCategoryLabel() {
    bottomStackView.addArrangedSubview(categoryLabel)
    categoryLabel.text = "Продукты"
    categoryLabel.textColor = .baseWhite
    categoryLabel.textAlignment = .left
  }
  
  private func setupAmountLabel() {
    bottomStackView.addArrangedSubview(amountLabel)
    amountLabel.text = "Осталось: 200$"
    amountLabel.textColor = .baseWhite
    amountLabel.textAlignment = .right
  }
}
