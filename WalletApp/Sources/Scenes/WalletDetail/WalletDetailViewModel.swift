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

class WalletDetailViewModel: SimpleViewStateProcessable {
  // MARK: - Properties
  weak var delegate: WalletDetailViewModelDelegate?
  
  var cellViewModels: [OperationCellViewModelProtocol] {
    return operations.compactMap { OperationCellViewModel($0) }
  }
  
  var bottomBarConfiguration: WalletBottomBarConfiguration {
    return .walletDetail
  }
  
  let balanceViewModel = BalanceViewModel()
  
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
        self.viewState.value = self.processResult(operations)
        self.configureBalanceModel(with: operations)
      case .failure(let error):
        print("Failed to get operations \(error)")
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
