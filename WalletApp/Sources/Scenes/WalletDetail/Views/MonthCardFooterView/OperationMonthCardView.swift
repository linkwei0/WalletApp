//
//  OperationTotalView.swift
//  WalletApp
//
//  Created by Артём Бацанов on 07.11.2023.
//

import UIKit

class OperationMonthCardView: UIView {
  // MARK: - Properties
  private let containerView = UIView()
  private let titleLabel = Label(textStyle: .body)
  private let stackView = UIStackView()
  private let categoryLabel = Label(textStyle: .bodyBold)
  private let amountLabel = Label(textStyle: .footnoteBold)
  
  private let maxCharsCount: Int = 8
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  // MARK: - Configure
  func configure(with viewModel: OperationMonthCardViewModel?) {
    titleLabel.text = R.string.walletDetail.monthCardViewCategory() + " " + (viewModel?.title ?? "")
    titleLabel.textColor = viewModel?.titleTextColor
    categoryLabel.text = viewModel?.category
    amountLabel.text = viewModel?.totalAmount.maxLength(to: maxCharsCount)
  }
  
  // MARK: - Setup
  private func setup() {
    setupContainer()
    setupTitleLabel()
    setupCategoryLabel()
    setupAmountLabel()
    setupStackView()
  }
  
  private func setupContainer() {
    addSubview(containerView)
    containerView.layer.cornerRadius = 12
    containerView.backgroundColor = .baseWhite
    containerView.addShadow(offset: CGSize(width: 0, height: 8), radius: 24, color: .zeroBlack, opacity: 0.15)
    containerView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  private func setupTitleLabel() {
    containerView.addSubview(titleLabel)
    titleLabel.textColor = .baseBlack
    titleLabel.textAlignment = .left
    titleLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(8)
      make.leading.equalToSuperview().inset(10)
    }
  }
  
  private func setupCategoryLabel() {
    containerView.addSubview(categoryLabel)
    categoryLabel.textColor = .baseBlack
    categoryLabel.textAlignment = .left
  }
  
  private func setupAmountLabel() {
    containerView.addSubview(amountLabel)
    amountLabel.textColor = .baseBlack
    amountLabel.numberOfLines = 1
    amountLabel.textAlignment = .left
  }
  
  private func setupStackView() {
    containerView.addSubview(stackView)
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    stackView.spacing = 12
    [categoryLabel, amountLabel].forEach { stackView.addArrangedSubview($0) }
    stackView.snp.makeConstraints { make in
      make.bottom.equalToSuperview().inset(8)
      make.leading.trailing.equalToSuperview().inset(10)
    }
  }
}
