//
//  OperationEditCell.swift
//  WalletApp
//
//  Created by Артём Бацанов on 31.10.2023.
//

import UIKit

class OperationEditCell: UITableViewCell {
  // MARK: - Properties
  private let containerView = UIView()
  private let operationCategoryButton = UIButton(type: .system)
  private let amountTextField = UITextField()
  private let moreInfoTextView = UITextView()
  
  private var viewModel: OperationEditCellViewModelProtocol?
  
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
  func configure(with viewModel: OperationEditCellViewModelProtocol) {
    self.viewModel = viewModel
    
    amountTextField.placeholder = viewModel.placeholderContentTextField
    
    operationCategoryButton.setTitle(viewModel.titleOperationCategory, for: .normal)
    amountTextField.text = viewModel.textContentTextField
    moreInfoTextView.text = viewModel.textMoreInfoTextView
    
    operationCategoryButton.isHidden = viewModel.isHiddenOperationCategoryButton
    amountTextField.isHidden = viewModel.isHiddenContentTextField
    moreInfoTextView.isHidden = viewModel.isHiddenMoreInfoTextView
  }
  
  // MARK: - Setup
  private func setup() {
    selectionStyle = .none
    setupContainerView()
    setupOperationCategoryButton()
    setupContentTextField()
    setupMoreInfoTextView()
  }
  
  private func setupContainerView() {
    contentView.addSubview(containerView)
    containerView.layer.cornerRadius = 16
    containerView.layer.borderWidth = 1.0
    containerView.layer.borderColor = UIColor.accent.cgColor
    containerView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(8)
      make.leading.trailing.equalToSuperview().inset(16)
    }
  }
  
  private func setupOperationCategoryButton() {
    containerView.addSubview(operationCategoryButton)
    operationCategoryButton.isHidden = true
    operationCategoryButton.tintColor = .baseBlack
    operationCategoryButton.titleLabel?.font = UIFont.bodyBold
    operationCategoryButton.titleLabel?.textAlignment = .left
    operationCategoryButton.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(4)
      make.leading.equalToSuperview().inset(8)
    }
  }
  
  private func setupContentTextField() {
    containerView.addSubview(amountTextField)
    amountTextField.isHidden = true
    amountTextField.textColor = .baseBlack
    amountTextField.addTarget(self, action: #selector(didChangeTextField(_:)), for: .editingChanged)
    amountTextField.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(4)
      make.leading.trailing.equalToSuperview().inset(8)
    }
  }
  
  private func setupMoreInfoTextView() {
    containerView.addSubview(moreInfoTextView)
    moreInfoTextView.isHidden = true
    moreInfoTextView.font = UIFont.body
    moreInfoTextView.isScrollEnabled = false
    moreInfoTextView.delegate = self
    moreInfoTextView.textColor = .baseBlack
    moreInfoTextView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(4)
      make.leading.trailing.equalToSuperview().inset(8)
      make.height.greaterThanOrEqualTo(50).priority(999)
    }
  }
  
  // MARK: - Actions
  @objc private func didChangeTextField(_ textField: UITextField) {
    viewModel?.amountTextFieldDidChange(textField.text ?? "")
  }
}

extension OperationEditCell: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    viewModel?.textViewDidChangeUpdateTableView()
    viewModel?.definitionTextViewDidChange(textView.text)
  }
}
