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
  private let titleLabel = Label(textStyle: .bodyBold)
  private let stackView = UIStackView()
  private let categoryLabel = Label(textStyle: .body)
  private let amountLabel = Label(textStyle: .footnoteBold)
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
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
  func configure(with viewModel: OperationMonthCardViewModel?) {
    titleLabel.text = "Категория" + " " + (viewModel?.title ?? "")
    categoryLabel.text = viewModel?.category
    amountLabel.text = viewModel?.totalAmount
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
    containerView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(20)
      make.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  private func setupTitleLabel() {
    containerView.addSubview(titleLabel)
    titleLabel.textColor = .baseWhite
    titleLabel.textAlignment = .left
    titleLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(8)
      make.leading.equalToSuperview().inset(10)
    }
  }
  
  private func setupCategoryLabel() {
    containerView.addSubview(categoryLabel)
    categoryLabel.textColor = .baseWhite
    categoryLabel.textAlignment = .left
  }
  
  private func setupAmountLabel() {
    containerView.addSubview(amountLabel)
    amountLabel.textColor = .baseWhite
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
