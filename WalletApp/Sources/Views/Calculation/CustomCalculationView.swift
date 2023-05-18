//
//  CustomCalculationView.swift
//  WalletApp
//
//  Created by Артём Бацанов on 11.05.2023.
//

import UIKit

protocol CustomCalculationViewDelegate: AnyObject {
  func didTapClearButton(_ view: CustomCalculationView, text: String)
  func didTapAllClearButton(_ view: CustomCalculationView)
  func didTapCheckButton(_ view: CustomCalculationView, with value: String)
}

class CustomCalculationView: UIView {
  // MARK: - Propeties
  
  weak var delegate: CustomCalculationViewDelegate?
  
  private let historyTableView = UITableView()
  private let currentSignLabel = Label(textStyle: .bodyBold)
  private let supportingValueLabel = Label(textStyle: .bodyBold)
  private let currentValueLabel = Label(textStyle: .header1)
  private let checkButton = UIButton(type: .system)
  private let allClearButton = UIButton(type: .system)
  private let clearButton = UIButton(type: .system)
  
  private let collectionType: CollectionType
  
  private let viewModel: CustomCalculationViewViewModel
  
  // MARK: - Init
  
  init(viewModel: CustomCalculationViewViewModel, collectionType: CollectionType) {
    self.viewModel = viewModel
    self.collectionType = collectionType
    super.init(frame: .zero)
    setup()
    bindToViewModel()
  }
  
  required init?(coder: NSCoder) {
    self.viewModel = CustomCalculationViewViewModel()
    self.collectionType = .income
    super.init(coder: coder)
    setup()
    bindToViewModel()
  }
  
  private func bindToViewModel() {
    viewModel.onUpdateCurrentValue = { [weak self] value in
      self?.currentValueLabel.text = value
    }
    
    viewModel.onUpdateAllValues = { [weak self] currentValue, currentSign in
      self?.currentSignLabel.text = currentSign
      self?.supportingValueLabel.text = currentValue
      self?.currentValueLabel.text = ""
    }
    
    viewModel.onUpdateUIAfterEqual = { [weak self] resultValue in
      self?.currentValueLabel.text = resultValue
      self?.currentSignLabel.text = ""
      self?.supportingValueLabel.text = ""
    }
  }
  
  // MARK: - Setup
  
  private func setup() {
    setupCurrentSignLabel()
    setupSupportingValueLabel()
    setupCheckButton()
    setupAllClearButton()
    setupClearButton()
    setupCurrentValueLabel()
    setupHistoryTableView()
  }
  
  private func setupCurrentSignLabel() {
    addSubview(currentSignLabel)
    currentSignLabel.textColor = collectionType == .income ? .baseWhite : .baseBlack
    currentSignLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(16)
      make.bottom.equalToSuperview().inset(5)
      make.size.equalTo(15)
    }
  }
  
  private func setupSupportingValueLabel() {
    addSubview(supportingValueLabel)
    supportingValueLabel.textColor = collectionType == .income ? .baseWhite : .baseBlack
    supportingValueLabel.textAlignment = .left
    supportingValueLabel.adjustsFontSizeToFitWidth = true
    supportingValueLabel.snp.makeConstraints { make in
      make.leading.equalTo(currentSignLabel.snp.trailing).offset(2)
      make.bottom.equalToSuperview()
      make.width.equalTo(60)
    }
  }
  
  private func setupCheckButton() {
    addSubview(checkButton)
    let image = R.image.checkButton()?.withRenderingMode(.alwaysTemplate)
    checkButton.setImage(image, for: .normal)
    checkButton.tintColor = collectionType == .income ? .baseWhite : .baseBlack
    checkButton.addTarget(self, action: #selector(didTapCheckButton), for: .touchUpInside)
    
    checkButton.snp.makeConstraints { make in
      make.trailing.equalToSuperview().inset(16)
      make.bottom.equalToSuperview()
      make.size.equalTo(40)
    }
  }
  
  private func setupAllClearButton() {
    addSubview(allClearButton)
    let image = R.image.allClearButton()?.withRenderingMode(.alwaysTemplate)
    allClearButton.setImage(image, for: .normal)
    allClearButton.tintColor = collectionType == .income ? .baseWhite : .baseBlack
    allClearButton.addTarget(self, action: #selector(didTapAllClearButton), for: .touchUpInside)
    
    allClearButton.snp.makeConstraints { make in
      make.right.equalTo(checkButton.snp.left).inset(-8)
      make.bottom.equalToSuperview()
      make.size.equalTo(40)
    }
  }
  
  private func setupClearButton() {
    addSubview(clearButton)
    let image = R.image.clearButton()?.withRenderingMode(.alwaysTemplate)
    clearButton.setImage(image, for: .normal)
    clearButton.tintColor = collectionType == .income ? .baseWhite : .baseBlack
    clearButton.addTarget(self, action: #selector(handleClearButton), for: .touchUpInside)
    
    clearButton.snp.makeConstraints { make in
      make.trailing.equalTo(allClearButton.snp.leading).inset(-8)
      make.bottom.equalToSuperview()
      make.size.equalTo(40)
    }
  }
  
  private func setupCurrentValueLabel() {
    addSubview(currentValueLabel)
    currentValueLabel.textColor = collectionType == .income ? .baseWhite : .baseBlack
    currentValueLabel.textAlignment = .center
    currentValueLabel.adjustsFontSizeToFitWidth = true
    currentValueLabel.snp.makeConstraints { make in
      make.leading.equalTo(supportingValueLabel.snp.trailing).offset(16)
      make.trailing.equalTo(clearButton.snp.leading).offset(-32)
      make.bottom.equalToSuperview()
      make.height.equalTo(40)
    }
  }
  
  private func setupHistoryTableView() {
    addSubview(historyTableView)
    historyTableView.dataSource = self
    historyTableView.delegate = self
    historyTableView.backgroundColor = .accent
    historyTableView.separatorStyle = .singleLine
    historyTableView.rowHeight = 50
    historyTableView.separatorColor = collectionType == .income ? .baseWhite : .baseBlack
    historyTableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    historyTableView.isScrollEnabled = false
    historyTableView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.trailing.equalToSuperview()
      make.bottom.equalTo(currentValueLabel.snp.top).inset(-14)
    }
  }
  
  // MARK: - IBActions
  
  @objc private func didTapCheckButton() {
    viewModel.onDidTapCheckButton(currentValueLabel.text ?? "")
  }
  
  @objc private func handleClearButton() {
    viewModel.onDidTapClearButton(value: currentValueLabel.text ?? "")
  }
  
  @objc private func didTapAllClearButton() {
    viewModel.onDidTapAllClearButton()
  }
}

// MARK: - UITableViewDataSource

extension CustomCalculationView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = "Test table cell"
    cell.textLabel?.textColor = collectionType == .income ? .baseWhite : .baseBlack
    cell.backgroundColor = .accent
    return cell
  }
}

// MARK: - UITableViewDelegate

extension CustomCalculationView: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // TODO: - segue to detail about day of order
    print(indexPath.row)
  }
}
