//
//  OperationEditCellViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 31.10.2023.
//

import UIKit

protocol OperationEditCellViewModelStringsProtocol {
  var titleOperationCategory: String { get }
  var placeholderContentTextField: String { get }
  var textContentTextField: String { get }
  var textMoreInfoTextView: String { get }
  var currency: String { get }
  var maxCharsCount: Int { get }
  var categoryTitleImageView: UIImage? { get }
  var onNeedsToUpdateCharsCountLabel: ((String, String) -> Void)? { get set }
}

protocol OperationEditCellViewModelBoolsProtocol {
  var isHiddenOperationCategoryLabel: Bool { get }
  var isHiddenContentTextField: Bool { get }
  var isHiddenMoreInfoTextView: Bool { get }
  var isHiddenCurrencyLabel: Bool { get }
  var isHiddenMaxCharsLabel: Bool { get }
  var isHiddenCategoryImageView: Bool { get }
}

protocol OperationEditCellViewModelMethodsProtocol {
  func categoryDidChange(_ category: String)
  func amountTextFieldDidChange(_ text: String)
  func definitionTextViewDidChange(_ text: String)
}

protocol OperationEditCellViewModelDelegate: AnyObject {
  func operationEditViewModelDidChangeOperationCategory(_ viewModel: OperationEditCellViewModel, text category: String)
  func operationEditViewModelDidChangeOperationAmount(_ viewModel: OperationEditCellViewModel, text amount: String)
  func operationEditViewModelDidChangeOperationDefinition(_ viewModel: OperationEditCellViewModel, text definition: String)
}

typealias OperationEditCellViewModelProtocols = OperationEditCellViewModelStringsProtocol
                                          & OperationEditCellViewModelBoolsProtocol
                                          & OperationEditCellViewModelMethodsProtocol

class OperationEditCellViewModel {
  // MARK: - Properties
  weak var delegate: OperationEditCellViewModelDelegate?
  
  var onNeedsToUpdateCharsCountLabel: ((_ charsCounter: String, _ maxCharsCount: String) -> Void)?
  
  private var charsCounter: Int = 0
  
  private let operation: OperationModel
  private let type: OperationEditCellType
  private let currencyCode: String
  
  // MARK: - Init
  init(with operation: OperationModel, type: OperationEditCellType, currencyCode: String) {
    self.operation = operation
    self.type = type
    self.currencyCode = currencyCode
  }
  
  // MARK: - Private methods
  private func didChangeOperationDefinition(_ text: String) {
    charsCounter = text.count
    if charsCounter < maxCharsCount {
      onNeedsToUpdateCharsCountLabel?("\(charsCounter)", "\((maxCharsCount))")
    }
  }
}

// MARK: - OperationEditCellViewModelStringsProtocol
extension OperationEditCellViewModel: OperationEditCellViewModelStringsProtocol {
  var titleOperationCategory: String {
    return operation.name
  }
  
  var placeholderContentTextField: String {
    return type.placeholderContentTextField
  }
  
  var textContentTextField: String {
    return NSDecimalNumber(decimal: operation.amount).stringValue
  }
  
  var currency: String {
    return (CurrencyModelView.WalletsCurrencyType(rawValue: currencyCode) ?? .rub).title
  }
  
  var textMoreInfoTextView: String {
    return operation.definition ?? ""
  }
  
  var maxCharsCount: Int {
    return 180
  }
  
  var categoryTitleImageView: UIImage? {
    return operation.type.isIncome == true ? IncomeCategoryTypes(rawValue: operation.category)?.image 
                                                : ExpenseCategoryTypes(rawValue: operation.category)?.image
  }
}

// MARK: - OperationEditCellViewModelBoolsProtocol
extension OperationEditCellViewModel: OperationEditCellViewModelBoolsProtocol {
  var isHiddenOperationCategoryLabel: Bool {
    return type.isHiddenOperationCategoryButton
  }
  
  var isHiddenContentTextField: Bool {
    return type.isHiddenContentTextField
  }
  
  var isHiddenMoreInfoTextView: Bool {
    return type.isHiddenMoreInfoTextView
  }
  
  var isHiddenCurrencyLabel: Bool {
    return type.isHiddenCurrencyLabel
  }
  
  var isHiddenMaxCharsLabel: Bool {
    return type.isHiddenMaxCharsLabel
  }
  
  var isHiddenCategoryImageView: Bool {
    return type.isHiddenCategoryImageView
  }
}

// MARK: - OperationEditCellViewModelProtocol
extension OperationEditCellViewModel: OperationEditCellViewModelMethodsProtocol {
  func categoryDidChange(_ category: String) {
    delegate?.operationEditViewModelDidChangeOperationCategory(self, text: category)
  }
  
  func amountTextFieldDidChange(_ text: String) {
    delegate?.operationEditViewModelDidChangeOperationAmount(self, text: text)
  }
  
  func definitionTextViewDidChange(_ text: String) {
    didChangeOperationDefinition(text)
    delegate?.operationEditViewModelDidChangeOperationDefinition(self, text: text)
  }
}
