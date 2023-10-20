//
//  CreateWalletCell.swift
//  WalletApp
//
//  Created by Артём Бацанов on 11.10.2023.
//

import UIKit

class CreateWalletCell: UITableViewCell {
  // MARK: - Properties
  var viewModel: CreateWalletCellViewModelProtocol? {
    didSet {
      guard let viewModel = viewModel else { return }
      configure()
    }
  }
  
  private let containerView = UIView()
  private let titleLabel = Label(textStyle: .body)
  private let contentTextField = UITextField()
  
  // MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  // MARK: Configure
  func configure() {
    guard let viewModel = viewModel else { return }
    titleLabel.text = viewModel.title
    contentTextField.placeholder = viewModel.placeholder
    contentTextField.tag = viewModel.tag
  }
  
  // MARK: - Setups
  private func setup() {
    selectionStyle = .none
    setupContainerView()
    setupTitleLabel()
    setupContentTextField()
  }
  
  private func setupContainerView() {
    contentView.addSubview(containerView)
    containerView.layer.cornerRadius = 12
    containerView.layer.borderColor = UIColor.accent.cgColor
    containerView.layer.borderWidth = 1.0
    containerView.snp.makeConstraints { make in
      make.top.bottom.leading.trailing.equalToSuperview().inset(16)
    }
  }
  
  private func setupTitleLabel() {
    containerView.addSubview(titleLabel)
    titleLabel.textColor = .baseBlack
    titleLabel.textAlignment = .left
    titleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(16)
      make.top.bottom.equalToSuperview().inset(8)
      make.width.equalTo(75)
    }
  }
  
  private func setupContentTextField() {
    containerView.addSubview(contentTextField)
    contentTextField.textColor = .baseBlack
    contentTextField.font = UIFont.bodyBold
    contentTextField.textAlignment = .left
    contentTextField.delegate = self
    contentTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    
    contentTextField.snp.makeConstraints { make in
      make.centerY.equalTo(titleLabel.snp.centerY)
      make.leading.equalTo(titleLabel.snp.trailing).offset(16)
      make.trailing.equalToSuperview().inset(16)
      make.height.equalTo(50)
    }
  }
  
  // MARK: - Selectors
  @objc private func textFieldDidChange(_ textField: UITextField) {
    viewModel?.textFieldDidChange(with: textField.tag, text: textField.text ?? "")
  }
}

extension CreateWalletCell: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let viewModel = viewModel else { return false }
    let currentString = (textField.text ?? "") as NSString
    let newString = currentString.replacingCharacters(in: range, with: string)

    let result = viewModel.getMaxCharsInTextField(textField.tag, newString: newString)
    
    return result
  }
}
