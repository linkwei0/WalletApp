//
//  WalletCell.swift
//  WalletApp
//
//  Created by Артём Бацанов on 16.10.2023.
//

import UIKit

class WalletCell: UITableViewCell {
  // MARK: - Properties
  private let nameLabel = Label(textStyle: .body)
  private let currencyLabel = Label(textStyle: .bodyBold)
  
  private var viewModel: WalletCellViewModelProtocol?
  
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
  func configure(with viewModel: WalletCellViewModelProtocol) {
    self.viewModel = viewModel
    
    nameLabel.text = viewModel.name
    currencyLabel.text = viewModel.currency
  }
  
  // MARK: - Setup
  private func setup() {
    selectionStyle = .none
    setupNameLabel()
    setupCurrencyLabel()
  }
  
  private func setupNameLabel() {
    contentView.addSubview(nameLabel)
    nameLabel.textColor = .baseBlack
    nameLabel.textAlignment = .left
    
    nameLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(16)
      make.centerY.equalToSuperview()
    }
  }
  
  private func setupCurrencyLabel() {
    contentView.addSubview(currencyLabel)
    currencyLabel.textColor = .systemGray5
    currencyLabel.textAlignment = .left
    
    currencyLabel.snp.makeConstraints { make in
      make.trailing.equalToSuperview().inset(24)
      make.centerY.equalToSuperview()
    }
  }
}
