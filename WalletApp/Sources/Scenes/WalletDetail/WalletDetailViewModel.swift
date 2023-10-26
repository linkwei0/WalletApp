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
  
  var bottomBarConfiguration: BankBottomBarConfiguration {
    return .walletDetail
  }
  
  let balanceViewModel = BalanceViewModel()
  
  private(set) var viewState: Bindable<SimpleViewState<OperationModel>> = Bindable(.initial)
    
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
        self.configureBalanceModel()
      case .failure(let error):
        print("Failed to get operations \(error)")
      }
    }
  }
  
  private func configureBalanceModel() {
    let balance = BalanceModel(totalBalance: wallet.balance, totalIncome: wallet.totalEarned, totalExpense: wallet.totalSpent)
    balanceViewModel.updateBalance(with: balance)
  }
}
