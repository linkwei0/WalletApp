//
//  WalletCell.swift
//  WalletApp
//

import UIKit

class WalletCell: UITableViewCell {
  // MARK: - Properties
  private let nameLabel = Label(textStyle: .body)
  private let currencyImageView = UIImageView()
  
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
    currencyImageView.image = CurrencyModelView.WalletsCurrencyType(rawValue: viewModel.currencyCode)?.iconImage
  }
  
  // MARK: - Setup
  private func setup() {
    setupBackground()
    setupNameLabel()
    setupCurrencyLabel()
  }
  
  private func setupBackground() {
    selectionStyle = .none
    let longTap = UILongPressGestureRecognizer(target: self, action: #selector(didLongTap(_:)))
    longTap.minimumPressDuration = 1
    longTap.delaysTouchesBegan = true
    contentView.addGestureRecognizer(longTap)
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
    contentView.addSubview(currencyImageView)
    currencyImageView.tintColor = .systemGray5
    currencyImageView.snp.makeConstraints { make in
      make.trailing.equalToSuperview().inset(24)
      make.centerY.equalToSuperview()
    }
  }
  
  // MARK: - Actions
  @objc private func didLongTap(_ sender: UILongPressGestureRecognizer) {
    if sender.state == .ended {
      viewModel?.didLongTap()
    }
  }
}
