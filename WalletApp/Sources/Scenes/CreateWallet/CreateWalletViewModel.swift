//
//  CreateWalletViewModel.swift
//  WalletApp
//

import Foundation

protocol CreateWalletViewModelDelegate: AnyObject {
  func viewModelDidRequestToWalletsScreen(_ viewModel: CreateWalletViewModel, wallet: WalletModel)
}

class CreateWalletViewModel {
  // MARK: - Properties
  weak var delegate: CreateWalletViewModelDelegate?
  
  var cellViewModels: [CreateWalletCellViewModelProtocol & UpdateWalletCellViewModelProtocol] {
    return contentForm.map { formType in
      let createWalletCellViewModel = CreateWalletCellViewModel(formType)
      createWalletCellViewModel.delegate = self
      return createWalletCellViewModel
    }
  }
  
  private var wallet = WalletModel.makeCleanModel()
  
  private let contentForm: [CreateWalletForm] = [.name, .currency, .balance]
  
  private let interactor: CreateWalletInteractor
  private let currencyRates: CurrencyRates
  
  // MARK: - Init
  init(interactor: CreateWalletInteractor, currencyRates: CurrencyRates) {
    self.interactor = interactor
    self.currencyRates = currencyRates
  }
  
  // MARK: - Public methods
  func createNewWallet() {
    if !wallet.name.isEmpty {
      interactor.saveWallet(wallet) { result in
        switch result {
        case .success:
          self.delegate?.viewModelDidRequestToWalletsScreen(self, wallet: self.wallet)
        case .failure(let error):
          print(error)
        }
      }
    }
  }
}

// MARK: - CreateWalletCellViewModelDelegate
extension CreateWalletViewModel: CreateWalletCellViewModelDelegate {
  func createWalletCellViewModelDidChangeTextField(_ viewModel: CreateWalletCellViewModel,
                                                   with textFieldTag: Int, text: String) {
    guard let formType = CreateWalletForm(rawValue: textFieldTag) else { return }
    switch formType {
    case .name:
      wallet.name = text
    case .balance:
      wallet.balance = Decimal(string: text) ?? 0
    case .currency:
      break
    }
  }
  
  func createWalletCellViewModelDidChangeSegmentedControl(_ viewModel: CreateWalletCellViewModel,
                                                          with selectedCurrency: CurrencyModelView.CreateWalletCurrencySegmentedControl) {
    switch selectedCurrency {
    case .rub:
      wallet.currency = CurrencyModel(value: 1,
                                      isIncrease: false,
                                      code: selectedCurrency.currencyType,
                                      description: "")
    case .usd:
      wallet.currency = CurrencyModel(value: currencyRates.usd,
                                      isIncrease: false,
                                      code: selectedCurrency.currencyType,
                                      description: "")
    case .euro:
      wallet.currency = CurrencyModel(value: currencyRates.euro,
                                      isIncrease: false,
                                      code: selectedCurrency.currencyType,
                                      description: "")
    }
  }
}
