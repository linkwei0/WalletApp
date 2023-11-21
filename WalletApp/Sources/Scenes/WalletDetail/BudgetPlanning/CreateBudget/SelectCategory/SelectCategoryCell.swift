//
//  SelectCategoryCell.swift
//  WalletApp
//
//  Created by Артём Бацанов on 21.11.2023.
//

import UIKit

class SelectCategoryCell: UITableViewCell {
  // MARK: - Properties
  private let stackView = UIStackView()
  private let nameLabel = Label(textStyle: .body)
  private let iconImageView = UIImageView()
  private let arrowImageView = UIImageView()
  
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
  func configure(with viewModel: SelectCategoryCellViewModelProtocol) {
    nameLabel.text = viewModel.name
    iconImageView.image = viewModel.icon
    arrowImageView.image = viewModel.arrow
  }
  
  // MARK: - Setup
  private func setup() {
    setupStackView()
    setupNameLabel()
    setupIconImageView()
    setupArrowImageView()
  }
  
  private func setupStackView() {
    contentView.addSubview(stackView)
    stackView.axis = .horizontal
    stackView.spacing = 2
    stackView.distribution = .fillEqually
    stackView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(20)
      make.leading.equalToSuperview().inset(24)
      make.width.equalTo(170)
    }
  }
  
  private func setupNameLabel() {
    stackView.addArrangedSubview(nameLabel)
    nameLabel.textColor = .baseBlack
    nameLabel.textAlignment = .left
  }
  
  private func setupIconImageView() {
    stackView.addArrangedSubview(iconImageView)
    iconImageView.contentMode = .scaleAspectFit
    iconImageView.clipsToBounds = true
    iconImageView.tintColor = .expenseColor
  }
  
  private func setupArrowImageView() {
    contentView.addSubview(arrowImageView)
    arrowImageView.contentMode = .scaleAspectFit
    arrowImageView.clipsToBounds = true
    arrowImageView.tintColor = .accent
    arrowImageView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(4)
      make.trailing.equalToSuperview().inset(24)
    }
  }
}
