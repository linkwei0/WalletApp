//
//  HistoryCell.swift
//  WalletApp
//
//  Created by Артём Бацанов on 20.06.2023.
//

import UIKit

class OperationCell: UITableViewCell {
  // MARK: - Properties
  
  private let titleLabel = Label(textStyle: .footnoteBold)
  
  var viewModel: OperationCellViewModelProtocol? {
    didSet {
      setupBindables()
    }
  }
  
  // MARK: - Init
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupUI()
  }
  
  // MARK: - Setup UI
  
  private func setupUI() {
    setupTitleLabel()
  }
  
  private func setupTitleLabel() {
    contentView.addSubview(titleLabel)
    titleLabel.textAlignment = .left
    titleLabel.numberOfLines = 0
    titleLabel.snp.makeConstraints { make in
      make.left.equalToSuperview().inset(12)
      make.centerY.equalToSuperview()
    }
  }
  
  // MARK: - Bindables
  
  private func setupBindables() {
    guard let viewModel = viewModel else { return }
    titleLabel.text = viewModel.name
    titleLabel.tintColor = viewModel.tintColor
  }
}
