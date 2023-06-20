//
//  CustomCalculationView.swift
//  WalletApp
//
//  Created by Артём Бацанов on 11.05.2023.
//

import UIKit

protocol CustomCalculationViewDelegate: AnyObject {
  func didTapClearButton(_ view: ExpressionView, text: String)
  func didTapAllClearButton(_ view: ExpressionView)
  func didTapCheckButton(_ view: ExpressionView, with value: String)
}

class ExpressionView: UIView {
  // MARK: - Propeties
  
  weak var delegate: CustomCalculationViewDelegate?
  
  private var dataSource: SimpleTableViewDataSoruce<ExpressionViewViewModel>?
  
  private let historyTableView = UITableView()
  private let currentSignLabel = Label(textStyle: .header1)
  private let supportingValueLabel = Label(textStyle: .header1)
  private let currentValueLabel = Label(textStyle: .header1)
  
  private let collectionType: CollectionType
  
  private let viewModel: ExpressionViewViewModel
  
  // MARK: - Init
  
  init(viewModel: ExpressionViewViewModel, collectionType: CollectionType) {
    self.viewModel = viewModel
    self.collectionType = collectionType
    super.init(frame: .zero)
    setup()
    bindToViewModel()
  }
  
  required init?(coder: NSCoder) {
    self.viewModel = ExpressionViewViewModel()
    self.collectionType = .income
    super.init(coder: coder)
    setup()
    bindToViewModel()
  }
  
  // MARK: - Setup
  
  private func setup() {
    setupHistoryTableView()
    setupCurrentValueLabel()
    setupSupportingValueLabel()
    setupCurrentSignLabel()
  }
  
  private func setupCurrentSignLabel() {
    addSubview(currentSignLabel)
    currentSignLabel.textColor = collectionType == .income ? .baseWhite : .baseBlack
    currentSignLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview()
      make.trailing.equalTo(supportingValueLabel.snp.leading).offset(-1)
      make.centerY.equalTo(supportingValueLabel.snp.centerY)
      make.size.equalTo(20)
    }
  }
  
  private func setupSupportingValueLabel() {
    addSubview(supportingValueLabel)
    supportingValueLabel.textColor = collectionType == .income ? .baseWhite : .baseBlack
    supportingValueLabel.textAlignment = .left
    supportingValueLabel.adjustsFontSizeToFitWidth = true
    supportingValueLabel.snp.makeConstraints { make in
      make.trailing.equalTo(currentValueLabel.snp.leading).offset(-4)
      make.bottom.equalTo(currentValueLabel.snp.bottom)
    }
  }
  
  private func setupCurrentValueLabel() {
    addSubview(currentValueLabel)
    currentValueLabel.textColor = collectionType == .income ? .baseWhite : .baseBlack
    currentValueLabel.textAlignment = .right
    currentValueLabel.font = UIFont.header1?.withSize(60)
    currentValueLabel.layer.borderColor = collectionType == .income ? UIColor.baseWhite.cgColor : UIColor.baseBlack.cgColor
    currentValueLabel.clipsToBounds = true
    currentValueLabel.adjustsFontSizeToFitWidth = true
    currentValueLabel.snp.makeConstraints { make in
      make.top.equalTo(historyTableView.snp.bottom).offset(6)
      make.bottom.equalToSuperview().inset(8)
      make.trailing.equalToSuperview()
      make.width.equalToSuperview().multipliedBy(0.6)
    }
  }
  
  private func setupHistoryTableView() {
    addSubview(historyTableView)
    historyTableView.dataSource = SimpleTableViewDataSoruce.make(for: viewModel.cellViewModels)
    historyTableView.delegate = self
    
    historyTableView.backgroundColor = .accentDark
    historyTableView.separatorStyle = .none
    historyTableView.rowHeight = 25
    historyTableView.separatorColor = collectionType == .income ? .baseWhite : .baseBlack
    historyTableView.isScrollEnabled = false
    historyTableView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.trailing.equalToSuperview()
      make.height.equalToSuperview().multipliedBy(0.65)
    }
  }
  
  // MARK: - Bindables
  
  private func bindToViewModel() {
    viewModel.currentValue.bind { [weak self] value in
      self?.currentValueLabel.text = value
    }
    
    viewModel.supprotingValue.bind { [weak self] value in
      self?.supportingValueLabel.text = value
    }
    
    viewModel.previousSign.bind { [weak self] sign in
      self?.currentSignLabel.text = sign
    }
    
    viewModel.getHistories()
  }
}

// MARK: - UITableViewDelegate

extension ExpressionView: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // TODO: - segue to detail about day of order
    print(indexPath.row)
  }
}
