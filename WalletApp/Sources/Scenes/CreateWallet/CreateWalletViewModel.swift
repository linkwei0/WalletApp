//
//  CreateWalletViewModel.swift
//  WalletApp
//

import Foundation

enum CreateWalletForm {
  case name, currency, balance
  
  var title: String {
    switch self {
    case .name:
      return "Название"
    case .currency:
      return "Валюта"
    case .balance:
      return "Баланс"
    }
  }
  
  var placeholder: String {
    switch self {
    case .name:
      return "Введите название кошелька"
    case .currency:
      return "Выберите валюту"
    case .balance:
      return "Изначальный баланс"
    }
  }
  
  var tag: Int {
    switch self {
    case .name:
      return 0
    case .currency:
      return 1
    case .balance:
      return 2
    }
  }
  
  var hiddenIfNotCurrency: Bool {
    switch self {
    case .name, .balance:
      return true
    case .currency:
      return false
    }
  }
  
  var hiddenIfNotTextField: Bool {
    switch self {
    case .name, .balance:
      return false
    case .currency:
      return true
    }
  }
}

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
  func createWalletCellViewModelDidChangeTextField(with textFieldTag: Int, text: String) {
    switch textFieldTag {
    case 0:
      wallet.name = text
    case 1:
      wallet.currency = text
    case 2:
      wallet.balance = Decimal(string: text) ?? 0
    default:
      return
    }
  }
}
