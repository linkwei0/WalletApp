//
//  WalletEditViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 08.11.2023.
//

import Foundation

protocol WalletEditViewModelDelegate: AnyObject {
  func walletEditViewModelSuccessfullyUpdated(_ viewModel: WalletEditViewModel)
}

class WalletEditViewModel {
  // MARK: - Properties
  weak var delegate: WalletEditViewModelDelegate?
  
  var onDidUpdate: (() -> Void)?
  
  private(set) var cellViewModels: [CreateWalletCellViewModelProtocol & UpdateWalletCellViewModelProtocol] = []
  
  private var wallet: WalletModel
  private let contentForm: [CreateWalletForm] = [.name, .currency, .balance]
  private let interactor: WalletEditInteractor
  private let currencyRates: CurrencyRates
  
  // MARK: - Init
  init(interactor: WalletEditInteractor, wallet: WalletModel, currencyRates: CurrencyRates) {
    self.interactor = interactor
    self.wallet = wallet
    self.currencyRates = currencyRates
  }
  
  // MARK: - Public methods
  func viewIsReady() {
    makeSections()
  }
  
  func saveWallet() {
    interactor.updateWallet(wallet: wallet) { result in
      switch result {
      case .success:
        self.delegate?.walletEditViewModelSuccessfullyUpdated(self)
      case .failure(let error):
        print("Failed to update wallet with \(error)")
      }
    }
  }
  
  // MARK: - Private methods
  private func makeSections() {
    cellViewModels.removeAll()
    contentForm.forEach { type in
      let cellViewModel = CreateWalletCellViewModel(type, wallet: wallet)
      cellViewModel.delegate = self
      cellViewModels.append(cellViewModel)
    }
    onDidUpdate?()
  }
}

// MARK: - CreateWalletCellViewModelDelegate
extension WalletEditViewModel: CreateWalletCellViewModelDelegate {
  func createWalletCellViewModelDidChangeTextField(_ viewModel: CreateWalletCellViewModel, with textFieldTag: Int, text: String) {
    guard let formType = CreateWalletForm(rawValue: textFieldTag) else { return }
    switch formType {
    case .name:
      wallet.name = text
    case .currency:
      break
    case .balance:
      wallet.balance = Decimal(string: text) ?? 0
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
