//
//  SelectPeriodCell.swift
//  WalletApp
//
//  Created by Артём Бацанов on 20.11.2023.
//

import UIKit

class SelectPeriodCell: UITableViewCell {
  // MARK: - Properties
  private let stackView = UIStackView()
  private let titleLabel = Label(textStyle: .body)
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
  func configure(with viewModel: SelectPeriodCellViewModelProtocol) {
    titleLabel.text = viewModel.title
    arrowImageView.image = viewModel.arrow
  }
  
  // MARK: - Setup
  private func setup() {
    selectionStyle = .none
    setupStackView()
    setupTitleLabel()
    setupArrowImageView()
  }
  
  private func setupStackView() {
    contentView.addSubview(stackView)
    stackView.axis = .horizontal
    stackView.spacing = 16
    stackView.distribution = .equalSpacing
    stackView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(6)
      make.leading.trailing.equalToSuperview().inset(24)
    }
  }
  
  private func setupTitleLabel() {
    stackView.addArrangedSubview(titleLabel)
    titleLabel.textAlignment = .left
    titleLabel.textColor = .baseBlack
  }
  
  private func setupArrowImageView() {
    stackView.addArrangedSubview(arrowImageView)
    arrowImageView.contentMode = .scaleAspectFit
    arrowImageView.clipsToBounds = true
    arrowImageView.tintColor = .accent
  }
}
