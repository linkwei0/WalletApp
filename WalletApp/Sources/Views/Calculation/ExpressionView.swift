//
//  CustomCalculationView.swift
//  WalletApp
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
  
  private let operationsTableView = UITableView()
  private let containerView = UIView()
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
    setupOperationsTableView()
    setupContainerView()
    setupCurrentSignLabel()
    setupSupportingValueLabel()
    setupCurrentValueLabel()
  }
  
  private func setupOperationsTableView() {
    addSubview(operationsTableView)
    operationsTableView.separatorStyle = .none
    operationsTableView.rowHeight = 50
    operationsTableView.backgroundColor = .accentLight
    operationsTableView.snp.makeConstraints { make in
      make.top.leading.trailing.equalToSuperview()
      make.height.equalToSuperview().multipliedBy(0.850)
    }
  }
  
  private func setupContainerView() {
    addSubview(containerView)
    containerView.backgroundColor = .shade2
    containerView.layer.cornerRadius = 16
    containerView.snp.makeConstraints { make in
      make.top.equalTo(operationsTableView.snp.bottom).offset(-16)
      make.leading.trailing.equalToSuperview()
      make.bottom.equalToSuperview().inset(8)
    }
  }
  
  private func setupCurrentSignLabel() {
    containerView.addSubview(currentSignLabel)
    currentSignLabel.textColor = .baseWhite
    currentSignLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(8)
      make.centerY.equalToSuperview()
      make.size.equalTo(15)
    }
  }
  
  private func setupSupportingValueLabel() {
    containerView.addSubview(supportingValueLabel)
    supportingValueLabel.textColor = .baseWhite
    supportingValueLabel.textAlignment = .left
    supportingValueLabel.adjustsFontSizeToFitWidth = true
    supportingValueLabel.snp.makeConstraints { make in
      make.leading.equalTo(currentSignLabel.snp.trailing).offset(6)
      make.centerY.equalTo(currentSignLabel.snp.centerY)
      make.width.equalToSuperview().multipliedBy(0.350)
    }
  }
  
  private func setupCurrentValueLabel() {
    containerView.addSubview(currentValueLabel)
    currentValueLabel.textColor = .baseWhite
    currentValueLabel.textAlignment = .right
    currentValueLabel.font = UIFont.header1?.withSize(45)
    currentValueLabel.clipsToBounds = true
    currentValueLabel.adjustsFontSizeToFitWidth = true
    currentValueLabel.snp.makeConstraints { make in
      make.leading.equalTo(supportingValueLabel.snp.trailing).inset(8)
      make.centerY.equalTo(supportingValueLabel.snp.centerY)
      make.trailing.equalToSuperview().inset(8)
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
    
    viewModel.getOperations()
  }
}
