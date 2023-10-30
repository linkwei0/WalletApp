//
//  WalletDetailViewModel.swift
//  WalletApp
//

import Foundation

protocol WalletDetailViewModelDelegate: AnyObject {
  func walletDetailViewModelDidRequestToShowIncome(_ viewModel: WalletDetailViewModel, wallet: WalletModel)
  func walletDetailViewModelDidRequestToShowExpense(_ viewModel: WalletDetailViewModel, wallet: WalletModel)
  func walletDetailViewModelDidRequestToShowProfile(_ viewModel: WalletDetailViewModel)
}

class WalletDetailViewModel: TableViewModel, SimpleViewStateProcessable {
  // MARK: - Properties
  weak var delegate: WalletDetailViewModelDelegate?
  
  var bottomBarConfiguration: WalletBottomBarConfiguration {
    return .walletDetail
  }
  
  let balanceViewModel = BalanceViewModel()
  
  private(set) var sectionViewModels: [TableSectionViewModel] = []
  private(set) var viewState: Bindable<SimpleViewState<OperationModel>> = Bindable(.initial)
  
  private var operations: [OperationModel] {
    return viewState.value.currentEntities
  }
  
  private var wallet: WalletModel
  private let interactor: WalletDetailInteractor
  
  // MARK: - Init
  init(interactor: WalletDetailInteractor, wallet: WalletModel) {
    self.interactor = interactor
    self.wallet = wallet
  }
  
  // MARK: - Public methods
  func viewIsReady() {
    fetchOperations()
  }
  
  func updateWallet() {
    setWallet()
    fetchOperations()
  }
  
  func didSelectBottomBarItem(_ itemType: WalletBottomBarItemType) {
    switch itemType {
    case .income:
      delegate?.walletDetailViewModelDidRequestToShowIncome(self, wallet: wallet)
    case .expense:
      delegate?.walletDetailViewModelDidRequestToShowExpense(self, wallet: wallet)
    case .profile:
      delegate?.walletDetailViewModelDidRequestToShowProfile(self)
    }
  }
  
  func isLastSection(_ section: Int) -> Bool {
    return sectionViewModels.count - 1 == section
  }
  
  // MARK: - Private methods
  private func setWallet() {
    interactor.getWallet(by: wallet.id) { result in
      switch result {
      case .success(let wallet):
        self.wallet = wallet
      case .failure(let error):
        print("Failed to get wallet by id with \(error)")
      }
    }
  }
  
  private func fetchOperations() {
    interactor.getOperations(for: wallet) { result in
      switch result {
      case .success(let operations):
        self.configureSectionByOperationsDate(operations)
        self.configureBalanceModel(with: operations)
        self.viewState.value = self.processResult(operations)
      case .failure(let error):
        print("Failed to get operations \(error)")
      }
    }
  }
  
  private func configureSectionByOperationsDate(_ operations: [OperationModel]) {
    sectionViewModels.removeAll()
    OperationDateType.allCases.forEach { operationDate in
      var operationsSection: [OperationModel] = []
      switch operationDate {
      case .today:
        let test = operations.first?.date ?? Date()
        operationsSection = operations.filter { $0.date.isToday() }
      case .yesterday:
        operationsSection = operations.filter { $0.date.isYesterday() }
      case .lastWeek:
        operationsSection = operations.filter { $0.date.isLastWeek() }
      }
      
      var headerTotalValue: Decimal = 0
      operationsSection = operationsSection.sorted { $0.date > $1.date }
      let itemViewModels = operationsSection.map { operation in
        headerTotalValue = operation.type.isIncome ? headerTotalValue + operation.amount : headerTotalValue - operation.amount
        let itemViewModel = OperationCellViewModel(operation)
        return itemViewModel
      }
      if !itemViewModels.isEmpty {
        let headerTotalValueString = headerTotalValue > 0 ? "+\(headerTotalValue)" : "-\(headerTotalValue)"
        let headerViewModel = OperationSectionHeaderViewModel(title: operationDate.title,
                                                              totalValue: headerTotalValueString,
                                                              isFirstSection: self.sectionViewModels.isEmpty)
        let section = TableSectionViewModel(headerViewModel: headerViewModel)
        section.append(cellViewModels: itemViewModels)
        self.sectionViewModels.append(section)
      }
    }
  }
  
  private func configureBalanceModel(with operations: [OperationModel]) {
    balanceViewModel.updateBalance(titleBalance: "Баланс кошелька", titleIncome: "Доходы кошелька",
                                   titleExpense: "Расходы кошелька", totalBalance: wallet.balance,
                                   totalIncome: wallet.totalEarned, totalExpense: wallet.totalSpent,
                                   currencyCode: wallet.currency.code)
  }
}
