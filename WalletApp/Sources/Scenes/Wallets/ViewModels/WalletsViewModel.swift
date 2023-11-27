//
//  WalletsViewModel.swift
//  WalletApp
//

import UIKit

protocol WalletsViewModelDelegate: AnyObject {
  func walletsViewModelDidRequestToShowWalletDetail(_ viewModel: WalletsViewModel, wallet: WalletModel)
  func walletsViewModelDidRequestToShowAddNewWallet(_ viewModel: WalletsViewModel, currencyRates: CurrencyRates)
  func walletsViewModelDidRequestToShowEditWallet(_ viewModel: WalletsViewModel, wallet: WalletModel, 
                                                  currencyRates: CurrencyRates)
}

final class WalletsViewModel: SimpleViewStateProccessable {
  // MARK: - Properties
  weak var delegate: WalletsViewModelDelegate?
  
  var cellViewModels: [WalletCellViewModelProtocol] {
    return viewState.value.currentEntities.compactMap { wallet in
      let cellViewModel = WalletCellViewModel(wallet)
      cellViewModel.delegate = self
      return cellViewModel
    }
  }
  
  var hasWallets: Bool {
    return !viewState.value.currentEntities.isEmpty
  }
  
  let balanceViewModel = BalanceViewModel()
  let currencyViewModel = CurrencyViewModel()
  
  private var currencyRates: CurrencyRates
      
  private(set) var viewState: Bindable<SimpleViewState<WalletModel>> = Bindable(.initial)
  
  private(set) var emptyStateViewModel: EmptyStateViewModel?
  
  private let interactor: WalletsInteractorProtocol
  
  private let currencyRateByDefault: Decimal = 1
  
  // MARK: - Init
  init(interactor: WalletsInteractorProtocol) {
    self.interactor = interactor
    currencyRates = CurrencyRates(usd: currencyRateByDefault, euro: currencyRateByDefault)
  }
  
  // MARK: - Public methods
  func viewIsReady() {
    fetchWallets()
    fetchCurrenciesRates()
  }
  
  func updateWallets() {
    fetchWallets()
    configureBalanceModel(with: viewState.value.currentEntities)
  }
  
  func addNewPersonWallet() {
    delegate?.walletsViewModelDidRequestToShowAddNewWallet(self, currencyRates: currencyRates)
  }
  
  func showSelectedWallet(at index: Int) {
    let wallet = viewState.value.currentEntities[index]
    delegate?.walletsViewModelDidRequestToShowWalletDetail(self, wallet: wallet)
  }
  
  func didSwipeToDelete(at indexPath: IndexPath) {
    deleteWallet(at: indexPath)
  }
  
  func didSwipeToEdit(at indexPath: IndexPath) {
    delegate?.walletsViewModelDidRequestToShowEditWallet(self, wallet: viewState.value.currentEntities[indexPath.row], 
                                                         currencyRates: currencyRates)
  }
  
  // MARK: - Private methods
  private func fetchWallets() {
    interactor.getWallets { result in
      switch result {
      case .success(let wallets):
        self.viewState.value = self.processResult(wallets)
        self.configureBalanceModel(with: wallets)
        if wallets.isEmpty {
          self.emptyStateViewModel = EmptyStateViewModel(image: UIImage(systemName: Constants.emptyImage),
                                                         imageSize: CGSize(width: 120, height: 120),
                                                         title: R.string.wallets.walletsEmptyViewTitle(),
                                                         subtitle: R.string.wallets.walletsEmptyViewSubtitle())
        }
      case .failure(let error):
        print(error)
      }
    }
  }
  
  private func fetchCurrenciesRates() {
    interactor.getCurrenciesRates { result in
      switch result {
      case .success(let currencies):
        self.updateCurrencyRates(currencies)
        self.currencyViewModel.configureCurrencyView(with: currencies)
      case .failure(let error):
        print("Failed to fetch currencies \(error)")
      }
    }
  }
  
  private func deleteWallet(at indexPath: IndexPath) {
    let walletID = viewState.value.currentEntities[indexPath.row].id
    interactor.deleteWallet(with: walletID) { result in
      switch result {
      case .success:
        self.updateWallets()
      case .failure(let error):
        print("Failed delete wallet with \(error)")
      }
    }
  }
  
  private func updateCurrencyRates(_ currencies: [CurrencyModel]) {
    var euroRate: Decimal = currencyRateByDefault
    var usdRate: Decimal = currencyRateByDefault

    currencies.forEach { currency in
      guard let currencyType = CurrencyModelView.WalletsCurrencyType(rawValue: currency.code) else { return }
      
      switch currencyType {
      case .euro:
        euroRate = currency.value
      case .usd:
        usdRate = currency.value
      case .rub:
        break
      }
    }
    currencyRates = CurrencyRates(usd: usdRate, euro: euroRate)
  }
  
  private func configureBalanceModel(with wallets: [WalletModel]) {
    var totalBalance: Decimal = 0
    var totalIncome: Decimal = 0
    var totalExpense: Decimal = 0
    var multiplierHelper: Decimal = 0
    
    wallets.forEach { wallet in
      guard let currencyType = CurrencyModelView.WalletsCurrencyType(rawValue: wallet.currency.code) else { return }

      switch currencyType {
      case .euro:
        multiplierHelper = wallet.currency.value
      case .usd:
        multiplierHelper = wallet.currency.value
      case .rub:
        multiplierHelper = wallet.currency.value
      }
      let walletBalance = wallet.balance * multiplierHelper
      let walletTotalEarned = wallet.totalEarned * multiplierHelper
      let walletTotalSpent = wallet.totalSpent * multiplierHelper

      totalBalance += walletBalance
      totalIncome += walletTotalEarned
      totalExpense += walletTotalSpent
    }
    
    balanceViewModel.updateBalance(titleBalance: R.string.balance.balanceViewWalletTotalTitle(),
                                   titleIncome: R.string.balance.balanceViewWalletsIncomeTitle(),
                                   titleExpense: R.string.balance.balanceViewWalletsExpenseTitle(),
                                   totalBalance: totalBalance, totalIncome: totalIncome,
                                   totalExpense: totalExpense, currencyCode: CurrencyModelView.WalletsCurrencyType.rub.title)
  }
}

// MARK: - WalletCellViewModelDelegate
extension WalletsViewModel: WalletCellViewModelDelegate {
  func cellViewModelDidLongTap(_ viewModel: WalletCellViewModel, wallet: WalletModel) {
    delegate?.walletsViewModelDidRequestToShowEditWallet(self, wallet: wallet, currencyRates: currencyRates)
  }
}

private extension Constants {
  static let emptyImage = "exclamationmark.triangle.fill"
}
