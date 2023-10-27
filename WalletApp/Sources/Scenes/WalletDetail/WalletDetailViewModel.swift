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
  
  var bottomBarConfiguration: BankBottomBarConfiguration {
    return .walletDetail
  }
  
  let balanceViewModel = BalanceViewModel()
  
  private(set) var viewState: Bindable<SimpleViewState<OperationModel>> = Bindable(.initial)
  
  private var operations: [OperationModel] {
    return viewState.value.currentEntities
  }
  
  private let wallet: WalletModel
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
    fetchOperations()
  }
  
  func didSelectBottomBarItem(_ itemType: BankBottomBarItemType) {
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
    let balance = BalanceModel(totalBalance: wallet.balance, totalIncome: wallet.totalEarned, totalExpense: wallet.totalSpent)
    balanceViewModel.updateBalance(with: balance)
  }
}
