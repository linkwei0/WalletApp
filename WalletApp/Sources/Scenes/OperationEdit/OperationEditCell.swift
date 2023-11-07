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
  private let operationCategoryLabel = Label(textStyle: .bodyBold)
  private let categoryImageView = UIImageView()
  private let amountTextField = UITextField()
  private let currencyLabel = Label(textStyle: .bodyBold)
  private let moreInfoTextView = UITextView()
  private let maxCharsLabel = Label(textStyle: .smallFootnote)
  
  private var viewModel: OperationEditCellViewModelProtocols?
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
  func configure(with viewModel: OperationEditCellViewModelProtocols) {
    self.viewModel = viewModel
    
    amountTextField.placeholder = viewModel.placeholderContentTextField
    
    operationCategoryLabel.text = viewModel.titleOperationCategory
    categoryImageView.image = viewModel.categoryTitleImageView
    amountTextField.text = viewModel.textContentTextField
    currencyLabel.text = viewModel.currency
    moreInfoTextView.text = viewModel.textMoreInfoTextView
    maxCharsLabel.text = "0/\(viewModel.maxCharsCount)"
    
    operationCategoryLabel.isHidden = viewModel.isHiddenOperationCategoryLabel
    categoryImageView.isHidden = viewModel.isHiddenCategoryImageView
    amountTextField.isHidden = viewModel.isHiddenContentTextField
    currencyLabel.isHidden = viewModel.isHiddenCurrencyLabel
    moreInfoTextView.isHidden = viewModel.isHiddenMoreInfoTextView
    maxCharsLabel.isHidden = viewModel.isHiddenMaxCharsLabel
    
    self.viewModel?.onNeedsToUpdateCharsCountLabel = { [weak self] currentCharsCount, maxCharsCount in
      self?.maxCharsLabel.text = currentCharsCount + "/" + maxCharsCount
    }
  }
  
  // MARK: - Setup
  private func setup() {
    selectionStyle = .none
    setupContainerView()
    setupOperationCategoryLabel()
    setupCategoryImageView()
    setupAmountTextField()
    setupCurrencyLabel()
    setupMoreInfoTextView()
    setupMaxCharsLabel()
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
  
  private func setupOperationCategoryLabel() {
    containerView.addSubview(operationCategoryLabel)
    operationCategoryLabel.isHidden = true
    operationCategoryLabel.tintColor = .baseBlack
    operationCategoryLabel.textAlignment = .left
    operationCategoryLabel.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(4)
      make.leading.equalToSuperview().inset(12)
    }
  }
  
  private func setupCategoryImageView() {
    containerView.addSubview(categoryImageView)
    categoryImageView.isHidden = true
    categoryImageView.tintColor = .shade2
    categoryImageView.contentMode = .scaleAspectFit
    categoryImageView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(4)
      make.trailing.equalToSuperview().inset(12)
    }
  }
  
  private func setupAmountTextField() {
    containerView.addSubview(amountTextField)
    amountTextField.isHidden = true
    amountTextField.textColor = .baseBlack
    amountTextField.addTarget(self, action: #selector(didChangeTextField(_:)), for: .editingChanged)
    amountTextField.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(4)
      make.leading.trailing.equalToSuperview().inset(12)
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
      make.leading.trailing.equalToSuperview().inset(12)
    }
  }
  
  private func setupCurrencyLabel() {
    containerView.addSubview(currencyLabel)
    currencyLabel.isHidden = true
    currencyLabel.textColor = .shade2
    currencyLabel.textAlignment = .right
    currencyLabel.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(4)
      make.trailing.equalToSuperview().inset(12)
    }
  }
  
  private func setupMaxCharsLabel() {
    containerView.addSubview(maxCharsLabel)
    maxCharsLabel.isHidden = true
    maxCharsLabel.textColor = .shade3
    maxCharsLabel.textAlignment = .right
    maxCharsLabel.snp.makeConstraints { make in
      make.bottom.equalToSuperview().inset(4)
      make.trailing.equalToSuperview().inset(12)
    }
  }
  
  // MARK: - Actions
  @objc private func didChangeTextField(_ textField: UITextField) {
    viewModel?.amountTextFieldDidChange(textField.text ?? "")
  }
}

extension OperationEditCell: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    viewModel?.definitionTextViewDidChange(textView.text)
  }
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    guard let viewModel = viewModel else { return false }
    let currentString = (textView.text ?? "") as NSString
    let newString = currentString.replacingCharacters(in: range, with: text)

    let result = newString.count <= viewModel.maxCharsCount
    
    return result
  }
}
