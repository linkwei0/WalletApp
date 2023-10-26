//
//  CreateWalletCellViewModel.swift
//  WalletApp
//

import Foundation

protocol CreateWalletCellViewModelProtocol {
  var title: String { get }
  var placeholder: String { get }
  var tag: Int { get }
  var isCurrency: Bool { get }
  var isTextField: Bool { get }
  
  func getMaxCharsInTextField(_ tagTextField: Int, newString: String) -> Bool
  
  func textFieldDidChange(with tag: Int, text: String)
  func segmentedControlDidChange(with selectedCurrency: CurrencyModelView.CreateWalletCurrencySegmentedControl)
}

protocol CreateWalletCellViewModelDelegate: AnyObject {
  func createWalletCellViewModelDidChangeTextField(_ viewModel: CreateWalletCellViewModel, with textFieldTag: Int, text: String)
  func createWalletCellViewModelDidChangeSegmentedControl(_ viewModel: CreateWalletCellViewModel,
                                            with selectedCurrency: CurrencyModelView.CreateWalletCurrencySegmentedControl)
}

class CreateWalletCellViewModel: CreateWalletCellViewModelProtocol {
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
  
  private let form: CreateWalletForm
  
  // MARK: - Init
  init(_ form: CreateWalletForm) {
    self.form = form
  }
  
  // MARK: - Public methods
  func textFieldDidChange(with tag: Int, text: String) {
    delegate?.createWalletCellViewModelDidChangeTextField(self, with: tag, text: text)
  }
  
  func segmentedControlDidChange(with selectedCurrency: CurrencyModelView.CreateWalletCurrencySegmentedControl) {
    delegate?.createWalletCellViewModelDidChangeSegmentedControl(self, with: selectedCurrency)
  }
  
  func getMaxCharsInTextField(_ tagTextField: Int, newString: String) -> Bool {
    switch tagTextField {
    case 0:
      return newString.count <= 20 ? true : false
    case 1:
      return newString.count <= 5 ? true : false
    case 2:
      return newString.count <= 10 ? true : false
    default:
      return false
    }
  }
}
