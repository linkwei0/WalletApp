//
//  HistoryCell.swift
//  WalletApp
//

import UIKit

typealias OperationItemCell = TableCellContainer<OperationItemView>

class OperationItemView: UIView, Configurable {
  // MARK: - Properties
  private let titleLabel = Label(textStyle: .body)
  private let categoryImageView = UIImageView()
  private let amountLabel = Label(textStyle: .body)
  private let stackView = UIStackView()
  
  private let maxCharsShowing: Int = 10
  
  // MARK: - Init
  init() {
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  // MARK: - Configure
  func configure(with viewModel: OperationCellViewModel) {
    titleLabel.text = viewModel.name
    amountLabel.text = (viewModel.isIncome ? "+" : "-") + viewModel.amount.maxLength(to: maxCharsShowing)
    amountLabel.textColor = viewModel.isIncome ? .incomeBtnColor : .expenseColor
    categoryImageView.image = viewModel.category.image
    categoryImageView.tintColor = viewModel.isIncome ? .incomeBtnColor : .expenseColor
  }
  
  // MARK: - Setup
  private func setup() {
    setupBackground()
    setupStackView()
    setupTitleLabel()
    setupCategoryImageView()
    setupAmountLabel()
  }
  
  private func setupBackground() {
    backgroundColor = .clear
  }
  
  private func setupTitleLabel() {
    titleLabel.textAlignment = .left
    titleLabel.textColor = .baseBlack
    titleLabel.numberOfLines = 0
  }
  
  private func setupCategoryImageView() {
    categoryImageView.contentMode = .scaleAspectFit
    categoryImageView.tintColor = .shade2
    categoryImageView.clipsToBounds = true
    categoryImageView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
    }
  }
  
  private func setupAmountLabel() {
    amountLabel.textAlignment = .right
    amountLabel.textColor = .baseBlack
    amountLabel.numberOfLines = 0
  }
  
  private func setupStackView() {
    addSubview(stackView)
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.spacing = 4
    
    [titleLabel, categoryImageView, amountLabel].forEach { stackView.addArrangedSubview($0) }
    
    stackView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(4)
      make.leading.trailing.equalToSuperview().inset(16)
    }
  }
}
