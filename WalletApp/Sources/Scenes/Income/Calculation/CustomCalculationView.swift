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
  let currentSignLabel = Label(textStyle: .bodyBold)
  let supportingValueLabel = Label(textStyle: .bodyBold)
  let currentValueLabel = Label(textStyle: .header1)
  private let checkButton = UIButton(type: .system)
  private let allClearButton = UIButton(type: .system)
  private let clearButton = UIButton(type: .system)
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
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
    currentSignLabel.textColor = .baseWhite
    currentSignLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(16)
      make.bottom.equalToSuperview().inset(5)
      make.size.equalTo(15)
    }
  }
  
  private func setupSupportingValueLabel() {
    addSubview(supportingValueLabel)
    supportingValueLabel.textColor = .baseWhite
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
    checkButton.tintColor = .baseWhite
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
    allClearButton.tintColor = .baseWhite
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
    clearButton.tintColor = .baseWhite
    clearButton.addTarget(self, action: #selector(handleClearButton), for: .touchUpInside)
    
    clearButton.snp.makeConstraints { make in
      make.trailing.equalTo(allClearButton.snp.leading).inset(-8)
      make.bottom.equalToSuperview()
      make.size.equalTo(40)
    }
  }
  
  private func setupCurrentValueLabel() {
    addSubview(currentValueLabel)
    currentValueLabel.textColor = .baseWhite
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
    historyTableView.separatorStyle = .none
    historyTableView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.trailing.equalToSuperview()
      make.bottom.equalTo(currentValueLabel.snp.top).inset(-24)
    }
  }
  
  // MARK: - IBActions
  
  @objc private func didTapCheckButton() {
    delegate?.didTapCheckButton(self, with: currentValueLabel.text ?? "")
  }
  
  @objc private func handleClearButton() {
    delegate?.didTapClearButton(self, text: currentValueLabel.text ?? "")
  }
  
  @objc private func didTapAllClearButton() {
    delegate?.didTapAllClearButton(self)
  }
}

// MARK: - UITableViewDataSource

extension CustomCalculationView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}

// MARK: - UITableViewDelegate

extension CustomCalculationView: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(indexPath.row)
  }
}
