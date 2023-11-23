//
//  BudgetCell.swift
//  WalletApp
//
//  Created by Артём Бацанов on 21.11.2023.
//

import UIKit
import SnapKit

class BudgetCell: UITableViewCell, TableCell {
  // MARK: - Properties
  private let containerView = UIView()
  private let stackView = UIStackView()
  private let periodTypeLabel = Label(textStyle: .header2)
  private let containerProgressView = UIView()
  private let progressView = UIView()
  private let bottomStackView = UIStackView()
  private let remainderAmountLabel = Label(textStyle: .bodyBold)
  private let categoryLabel = Label(textStyle: .body)
  private let currencyLabel = Label(textStyle: .bodyBold)
  
  private let defaultWidth: CGFloat = 0
  private let maxPercent: CGFloat = 100
  
  private var maxWidthConstraint: Constraint?
  private var currentWidthConstraint: Constraint?
  
  // MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  // MARK: - Lifecycle
  override func prepareForReuse() {
    super.prepareForReuse()
    currentWidthConstraint?.layoutConstraints[0].constant = defaultWidth
    layoutIfNeeded()
  }
  
  // MARK: - Configure
  func configure(with viewModel: TableCellViewModel) {
    guard let viewModel = viewModel as? BudgetCellViewModel else { return }
    periodTypeLabel.text = viewModel.period
    categoryLabel.text = viewModel.category
    remainderAmountLabel.text = viewModel.remainderBudget
    currencyLabel.text = viewModel.currencyTitle
    
    if let maxWidth = maxWidthConstraint?.layoutConstraints[0].constant {
      var currentWidth = (viewModel.progress * maxPercent * maxWidth) / maxPercent
      if currentWidth > maxWidth {
        currentWidth = maxWidth
      }
      UIView.animate(withDuration: 1.5) {
        self.currentWidthConstraint?.layoutConstraints[0].constant = currentWidth
        self.layoutIfNeeded()
      }
    }
  }
  
  // MARK: - Setup
  private func setup() {
    setupBackground()
    setupContainerView()
    setupStackView()
    setupPeriodTypeLabel()
    setupProgressView()
    setupBottomStackView()
    setupCategoryLabel()
    setupAmountLabel()
    setupCurrencyLabel()
  }
  
  private func setupBackground() {
    selectionStyle = .none
    backgroundColor = .clear
  }
  
  private func setupContainerView() {
    contentView.addSubview(containerView)
    containerView.layer.cornerRadius = 24
    containerView.backgroundColor = .accent
    containerView.layer.borderColor = UIColor.baseBlack.cgColor
    containerView.layer.borderWidth = 0.5
    containerView.addShadow(offset: CGSize(width: 0, height: 4), radius: 24, color: .zeroBlack, opacity: 0.1)
    containerView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(16)
      make.leading.trailing.equalToSuperview().inset(24)
    }
  }
  
  private func setupStackView() {
    containerView.addSubview(stackView)
    stackView.axis = .vertical
    stackView.spacing = 10
    stackView.distribution = .fill
    stackView.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
  
  private func setupPeriodTypeLabel() {
    stackView.addArrangedSubview(periodTypeLabel)
    periodTypeLabel.textColor = .baseWhite
    periodTypeLabel.textAlignment = .left
  }
  
  private func setupProgressView() {
    stackView.addArrangedSubview(containerProgressView)
    containerProgressView.backgroundColor = .shade2
    containerProgressView.layer.cornerRadius = 10
    containerProgressView.snp.makeConstraints { make in
      make.height.equalTo(20)
      maxWidthConstraint = make.width.equalTo(275).constraint
    }
    containerProgressView.addSubview(progressView)
    progressView.backgroundColor = .baseWhite
    progressView.layer.cornerRadius = 10
    progressView.snp.makeConstraints { make in
      make.top.bottom.leading.equalToSuperview()
      currentWidthConstraint = make.width.equalTo(defaultWidth).constraint
    }
  }
  
  private func setupBottomStackView() {
    stackView.addArrangedSubview(bottomStackView)
    bottomStackView.axis = .horizontal
    bottomStackView.spacing = 4
    bottomStackView.snp.makeConstraints { make in
      make.bottom.leading.trailing.equalToSuperview()
    }
  }
  
  private func setupCategoryLabel() {
    bottomStackView.addArrangedSubview(categoryLabel)
    categoryLabel.textColor = .baseWhite
    categoryLabel.textAlignment = .left
    
    let spacer = UIView()
    spacer.backgroundColor = .clear
    bottomStackView.addArrangedSubview(spacer)
  }
  
  private func setupAmountLabel() {
    bottomStackView.addArrangedSubview(remainderAmountLabel)
    remainderAmountLabel.textColor = .baseWhite
    remainderAmountLabel.textAlignment = .right
    remainderAmountLabel.snp.makeConstraints { make in
      make.width.equalTo(150)
    }
  }
  
  private func setupCurrencyLabel() {
    bottomStackView.addArrangedSubview(currencyLabel)
    currencyLabel.textColor = .baseWhite
    currencyLabel.textAlignment = .left
    currencyLabel.snp.makeConstraints { make in
      make.top.bottom.trailing.equalToSuperview()
    }
  }
}
