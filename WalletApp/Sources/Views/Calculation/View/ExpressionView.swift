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
  
  private var dataSource: SimpleTableViewDataSoruce<OperationCellViewModelProtocol>?
  
  private let operationsTableView = UITableView()
  private let containerView = UIView()
  private let currentSignLabel = Label(textStyle: .header1)
  private let previousValueLabel = Label(textStyle: .header1)
  private let currentValueLabel = Label(textStyle: .header1)
  
  private let collectionType: CollectionType
  
  private let viewModel: ExpressionViewModel
  
  // MARK: - Init
  init(viewModel: ExpressionViewModel, collectionType: CollectionType) {
    self.viewModel = viewModel
    self.collectionType = collectionType
    super.init(frame: .zero)
    setup()
    bindToViewModel()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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
    operationsTableView.rowHeight = 40
    operationsTableView.backgroundColor = .baseWhite
    operationsTableView.register(OperationCell.self, forCellReuseIdentifier: OperationCell.reuseIdentifiable)
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
      make.leading.trailing.equalToSuperview().inset(16)
      make.bottom.equalToSuperview().inset(8)
    }
  }
  
  private func setupCurrentSignLabel() {
    containerView.addSubview(currentSignLabel)
    currentSignLabel.textColor = .baseWhite
    currentSignLabel.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(12)
      make.leading.equalToSuperview().inset(8)
      make.width.equalTo(17)
    }
  }
  
  private func setupSupportingValueLabel() {
    containerView.addSubview(previousValueLabel)
    previousValueLabel.textColor = .baseWhite
    previousValueLabel.textAlignment = .left
    previousValueLabel.adjustsFontSizeToFitWidth = true
    previousValueLabel.snp.makeConstraints { make in
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
      make.leading.equalTo(previousValueLabel.snp.trailing).inset(8)
      make.centerY.equalTo(previousValueLabel.snp.centerY)
      make.trailing.equalToSuperview().inset(8)
    }
  }
  
  // MARK: - Private methods
  private func reloadTableView() {
    dataSource = SimpleTableViewDataSoruce.make(for: viewModel.cellViewModels)
    operationsTableView.dataSource = dataSource
    operationsTableView.reloadData()
  }
  
  private func configureOperationsTableView(with state: SimpleViewState<OperationModel>) {
    switch state {
    case .initial, .populated:
      print("Hide empty view")
    case .empty:
      print("Present empty view")
    case .error(let error):
      print("Present error \(error)")
    }
  }
  
  // MARK: - Bindables
  private func bindToViewModel() {
    viewModel.currentValue.bind { [weak self] value in
      self?.currentValueLabel.text = value
    }
    
    viewModel.supprotingValue.bind { [weak self] value in
      self?.previousValueLabel.text = value
    }
    
    viewModel.previousSign.bind { [weak self] sign in
      self?.currentSignLabel.text = sign
    }
    
    viewModel.viewState.bind { [weak self] state in
      guard let strongSelf = self else { return }
      DispatchQueue.main.async {
        strongSelf.configureOperationsTableView(with: state)
        strongSelf.reloadTableView()
      }
    }
    
    viewModel.getOperations()
  }
}
