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
  
  var cellViewModels: [CreateWalletCellViewModelProtocol] {
    return contentForm.map { formType in
      let createWalletCellViewModel = CreateWalletCellViewModel(formType)
      createWalletCellViewModel.delegate = self
      return createWalletCellViewModel
    }
  }
  
  private var wallet = WalletModel()
  
  private let contentForm: [CreateWalletForm] = [.name, .currency, .balance]
  
  private let interactor: CreateWalletInteractor
  
  // MARK: - Init
  init(interactor: CreateWalletInteractor) {
    self.interactor = interactor
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
    guard let typeForm = CreateWalletForm(rawValue: textFieldTag) else { return }
    switch typeForm {
    case .name:
      wallet.name = text
    case .balance:
      wallet.balance = Decimal(string: text) ?? 0
    case .currency:
      break
    }
  }
  
  func createWalletCellViewModelDidChangeSegmentedControl(_ viewModel: CreateWalletCellViewModel,
                                                          with selectedCurrency: CurrencyModelView.CreateWalletCurrencyType) {
    wallet.currency = selectedCurrency.currencyType
  }
}
