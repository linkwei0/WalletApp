//
//  WalletsViewModel.swift
//  WalletApp
//

import Foundation

protocol WalletsViewModelDelegate: AnyObject {
  func walletsViewModelDidRequestToShowWalletDetail(_ viewModel: WalletsViewModel, wallet: WalletModel)
  func walletsViewModelDidRequestToShowAddNewWallet(_ viewModel: WalletsViewModel)
}

final class WalletsViewModel: SimpleViewStateProcessable {
  // MARK: - Properties
  weak var delegate: WalletsViewModelDelegate?
  
  var cellViewModels: [WalletCellViewModelProtocol] {
    return viewState.value.currentEntities.compactMap { WalletCellViewModel($0) }
  }
  
  let balanceViewModel = BalanceViewViewModel()
      
  private(set) var viewState: Bindable<SimpleViewState<WalletModel>> = Bindable(.initial)
  
  private let interactor: WalletsInteractor
  
  // MARK: - Init
  init(interactor: WalletsInteractor) {
    self.interactor = interactor
  }
  
  // MARK: - Public methods
  func viewIsReady() {
    fetchWallets()
  }
  
  func addNewPersonWallet() {
    delegate?.walletsViewModelDidRequestToShowAddNewWallet(self)
  }
  
  func showSelectedWallet(at index: Int) {
    let wallet = viewState.value.currentEntities[index]
    delegate?.walletsViewModelDidRequestToShowWalletDetail(self, wallet: wallet)
  }
  
  // MARK: - Private methods
  private func fetchWallets() {
    interactor.getWallets { result in
      switch result {
      case .success(let wallets):
        self.viewState.value = self.processResult(wallets)
        self.configureBalanceModel(with: wallets)
      case .failure(let error):
        print(error)
      }
    }
  }
  
  private func configureBalanceModel(with wallets: [WalletModel]) {
    guard !wallets.isEmpty else { return }
    var totalBalance = 0
    var totalIncome = 0
    var totalExpense = 0
    
    wallets.forEach { wallet in
      totalBalance += NSDecimalNumber(decimal: wallet.balance).intValue
      totalIncome += NSDecimalNumber(decimal: wallet.totalSpent).intValue
      totalExpense += NSDecimalNumber(decimal: wallet.totalEarned).intValue
    }
    
    let balance = BalanceModel(totalBalance: totalBalance, totalIncome: totalIncome, totalExpense: totalExpense)
    balanceViewModel.setBalanceModel(balance)
  }
}
