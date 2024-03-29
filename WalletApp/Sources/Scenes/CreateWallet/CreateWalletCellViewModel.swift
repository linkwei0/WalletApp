//
//  CreateWalletCellViewModel.swift
//  WalletApp
//

import UIKit

protocol CreateWalletCellViewModelProtocol {
  var keyboardType: UIKeyboardType { get }
  var title: String { get }
  var placeholder: String { get }
  var tag: Int { get }
  var isCurrency: Bool { get }
  var isTextField: Bool { get }
  
  func getMaxCharsInTextField(_ tagTextField: Int, newString: String) -> Bool
  
  func textFieldDidChange(with tag: Int, text: String)
  func segmentedControlDidChange(with selectedCurrency: CurrencyModelView.CreateWalletCurrencySegmentedControl)
}

protocol UpdateWalletCellViewModelProtocol {
  var selectedCurrencyIndex: Int { get }
  var contentTextFieldTitle: String? { get }
}

protocol CreateWalletCellViewModelDelegate: AnyObject {
  func createWalletCellViewModelDidChangeTextField(_ viewModel: CreateWalletCellViewModel, with textFieldTag: Int, text: String)
  func createWalletCellViewModelDidChangeSegmentedControl(_ viewModel: CreateWalletCellViewModel,
                                                          with selectedCurrency: CurrencyModelView.CreateWalletCurrencySegmentedControl)
}

class CreateWalletCellViewModel: CreateWalletCellViewModelProtocol {
  private enum NumberCharsInRow {
    case name
    case balance
    
    var maxCharsCount: Int {
      switch self {
      case .name:
        return 20
      case .balance:
        return 10
      }
    }
  }
  
  // MARK: - Properties
  weak var delegate: CreateWalletCellViewModelDelegate?
  
  var title: String {
    return form.title
  }
  
  var placeholder: String {
    return form.placeholder
  }
  
  var tag: Int {
    return form.tag
  }
  
  var isCurrency: Bool {
    return form.hiddenIfNotCurrency
  }
  
  var isTextField: Bool {
    return form.hiddenIfNotTextField
  }
  
  var keyboardType: UIKeyboardType {
    return form.isNumberType ? .numberPad : .default
  }
  
  private let form: CreateWalletForm
  private var wallet: WalletModel?
  
  // MARK: - Init
  init(_ form: CreateWalletForm, wallet: WalletModel? = nil) {
    self.form = form
    self.wallet = wallet
  }
  
  // MARK: - Public methods
  func textFieldDidChange(with tag: Int, text: String) {
    delegate?.createWalletCellViewModelDidChangeTextField(self, with: tag, text: text)
  }
  
  func segmentedControlDidChange(with selectedCurrency: CurrencyModelView.CreateWalletCurrencySegmentedControl) {
    delegate?.createWalletCellViewModelDidChangeSegmentedControl(self, with: selectedCurrency)
  }
  
  func getMaxCharsInTextField(_ tagTextField: Int, newString: String) -> Bool {
    guard let rowType = CreateWalletForm(rawValue: tagTextField) else { return false }
    switch rowType {
    case .name:
      return newString.count <= NumberCharsInRow.name.maxCharsCount ? true : false
    case .balance:
      return newString.count <= NumberCharsInRow.balance.maxCharsCount ? true : false
    default:
      return false
    }
  }
}

// MARK: - UpdateWalletCellViewModelProtocol
extension CreateWalletCellViewModel: UpdateWalletCellViewModelProtocol {
  var contentTextFieldTitle: String? {
    switch form {
    case .name:
      return wallet?.name ?? ""
    case .currency:
      return nil
    case .balance:
      if let balance = wallet?.balance {
        return NSDecimalNumber(decimal: balance).stringValue
      }
      return nil
    }
  }
  
  var selectedCurrencyIndex: Int {
    let currencyToInt = CurrencyModelView.CreateWalletCurrencySegmentedControl(rawValue: wallet?.currency.code ?? "")
    return currencyToInt?.rawValue ?? 0
  }
}
