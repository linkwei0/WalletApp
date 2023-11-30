//
//  OperationSectionHeaderView.swift
//  WalletApp
//
//  Created by Артём Бацанов on 29.10.2023.
//

import UIKit

class OperationHeaderView: UITableViewHeaderFooterView, TableHeaderView {
  // MARK: - Properties
  private let titleLabel = Label(textStyle: .bodyBold)
  private let totalValueLabel = Label(textStyle: .bodyBold)
  
  private let topLine = UIView()
  private let bottomLine = UIView()
  
  // MARK: - Init
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  // MARK: - Configure
  func configure(with viewModel: TableHeaderViewModel) {
    guard let viewModel = viewModel as? OperationHeaderViewModel else { return }
    titleLabel.text = viewModel.title
    totalValueLabel.text = viewModel.totalValue.maxLength(to: 10)
    
    titleLabel.snp.remakeConstraints { make in
      make.top.equalToSuperview().inset(viewModel.topInset)
      make.leading.equalToSuperview().inset(16)
      make.bottom.equalToSuperview().inset(8).priority(999)
    }
    totalValueLabel.snp.remakeConstraints { make in
      make.top.equalToSuperview().inset(viewModel.topInset)
      make.trailing.equalToSuperview().inset(16)
      make.bottom.equalToSuperview().inset(8).priority(999)
    }
  }
  
  // MARK: - Setup
  private func setup() {
    setupTitleLabel()
    setupTotalValueLabel()
    setupTopLine()
    setupBottomLine()
  }
  
  private func setupTopLine() {
    contentView.addSubview(topLine)
    topLine.backgroundColor = .shade3
    topLine.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.top)
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(0.4)
    }
  }
  
  private func setupTitleLabel() {
    contentView.addSubview(titleLabel)
    titleLabel.textColor = .baseBlack
    titleLabel.numberOfLines = 0
    titleLabel.textAlignment = .left
  }
  
  private func setupTotalValueLabel() {
    contentView.addSubview(totalValueLabel)
    totalValueLabel.textColor = .baseBlack
    totalValueLabel.numberOfLines = 0
    totalValueLabel.textAlignment = .right
  }
  
  private func setupBottomLine() {
    contentView.addSubview(bottomLine)
    bottomLine.backgroundColor = .shade3
    bottomLine.snp.makeConstraints { make in
      make.bottom.equalTo(titleLabel.snp.bottom)
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(0.4)
    }
  }
}
