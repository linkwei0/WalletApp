//
//  HistoryCell.swift
//  WalletApp
//

import UIKit

class OperationCell: UITableViewCell {
  // MARK: - Properties
  private let titleLabel = Label(textStyle: .footnote)
  private let amountLabel = Label(textStyle: .footnoteBold)
  
  var viewModel: OperationCellViewModelProtocol? {
    didSet {
      setupBindables()
    }
  }
  
  // MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  // MARK: - Setup
  private func setup() {
    setupContainer()
    setupTitleLabel()
    setupAmountLabel()
  }
  
  private func setupContainer() {
    selectionStyle = .none
    backgroundColor = .accentLight
  }
  
  private func setupTitleLabel() {
    contentView.addSubview(titleLabel)
    titleLabel.textAlignment = .left
    titleLabel.numberOfLines = 0
    titleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(4)
      make.centerY.equalToSuperview()
    }
  }
  
  private func setupAmountLabel() {
    contentView.addSubview(amountLabel)
    amountLabel.textAlignment = .right
    amountLabel.numberOfLines = 0
    amountLabel.snp.makeConstraints { make in
      make.trailing.equalToSuperview().inset(4)
      make.centerY.equalToSuperview()
    }
  }
  
  // MARK: - Bindables
  private func setupBindables() {
    guard let viewModel = viewModel else { return }
    titleLabel.text = viewModel.name
    amountLabel.text = viewModel.amount
  }
}
