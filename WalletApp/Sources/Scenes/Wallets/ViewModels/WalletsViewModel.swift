//
//  WalletsViewModel.swift
//  WalletApp
//

import Foundation

protocol WalletsViewModelDelegate: AnyObject {
  func walletsViewModelDidRequestToShowWalletDetail(_ viewModel: WalletsViewModel, wallet: WalletModel)
  func walletsViewModelDidRequestToShowAddNewWallet(_ viewModel: WalletsViewModel, currencyRates: CurrencyRates)
}

final class WalletsViewModel: SimpleViewStateProcessable {
  // MARK: - Properties
  weak var delegate: WalletsViewModelDelegate?
  
  var cellViewModels: [WalletCellViewModelProtocol] {
    return viewState.value.currentEntities.compactMap { WalletCellViewModel($0) }
  }
  
  let balanceViewModel = BalanceViewModel()
  let currencyViewModel = CurrencyViewModel()
  
  private var currencyRates: CurrencyRates?
      
  private(set) var viewState: Bindable<SimpleViewState<WalletModel>> = Bindable(.initial)
  
  private let interactor: WalletsInteractor
  
  // MARK: - Init
  init(interactor: WalletsInteractor) {
    self.interactor = interactor
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
    delegate?.walletsViewModelDidRequestToShowAddNewWallet(self, currencyRates: currencyRates ?? CurrencyRates(usd: 1, euro: 1))
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
  
  private func updateCurrencyRates(_ currencies: [CurrencyModel]) {
    var euroRate: Decimal = 1
    var usdRate: Decimal = 1

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

    balanceViewModel.updateBalance(titleBalance: R.string.wallet.balanceViewTotalTitle(),
                                   titleIncome: R.string.wallet.balanceViewIncomeTitle(),
                                   titleExpense: R.string.wallet.balanceViewExpenseTitle(),
                                   totalBalance: totalBalance, totalIncome: totalIncome,
                                   totalExpense: totalExpense, currencyCode: CurrencyModelView.WalletsCurrencyType.rub.title)
  }
}
