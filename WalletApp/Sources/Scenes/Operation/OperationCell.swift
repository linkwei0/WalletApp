//
//  HistoryCell.swift
//  WalletApp
//

import UIKit

class OperationCell: UITableViewCell {
  // MARK: - Properties
  private let titleLabel = Label(textStyle: .body)
  private let categoryImageView = UIImageView()
  private let amountLabel = Label(textStyle: .footnoteBold)
  private let stackView = UIStackView()
  
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
  func configure(with viewModel: OperationCellViewModelProtocol) {
    titleLabel.text = viewModel.name
    amountLabel.text = (viewModel.isIncome ? "+" : "-") + viewModel.amount
    amountLabel.textColor = viewModel.isIncome ? .incomeBtnColor : .expenseBtnColor
    categoryImageView.image = viewModel.category.image
  }
  
  // MARK: - Setup
  private func setup() {
    setupContainer()
    setupStackView()
    setupTitleLabel()
    setupCategoryImageView()
    setupAmountLabel()
  }
  
  private func setupContainer() {
    selectionStyle = .none
    backgroundColor = .baseWhite
  }
  
  private func setupTitleLabel() {
    titleLabel.textAlignment = .left
    titleLabel.numberOfLines = 0
  }
  
  private func setupCategoryImageView() {
    categoryImageView.contentMode = .scaleAspectFit
    categoryImageView.tintColor = .shade2
    categoryImageView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
    }
  }
  
  private func setupAmountLabel() {
    amountLabel.textAlignment = .right
    amountLabel.numberOfLines = 0
  }
  
  private func setupStackView() {
    contentView.addSubview(stackView)
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.spacing = 16
    
    [titleLabel, categoryImageView, amountLabel].forEach { stackView.addArrangedSubview($0) }
    
    stackView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(4)
      make.leading.trailing.equalToSuperview().inset(16)
    }
  }
}
