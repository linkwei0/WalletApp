//
//  OperationEditCellViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 31.10.2023.
//

import Foundation

protocol OperationEditCellViewModelProtocol {
  var titleOperationCategory: String { get }
  var placeholderContentTextField: String { get }
  var textContentTextField: String { get }
  var textMoreInfoTextView: String { get }
  
  var isHiddenOperationCategoryButton: Bool { get }
  var isHiddenContentTextField: Bool { get }
  var isHiddenMoreInfoTextView: Bool { get }
  
  func textViewDidChangeUpdateTableView()
  func categoryDidChange(_ category: String)
  func amountTextFieldDidChange(_ text: String)
  func definitionTextViewDidChange(_ text: String)
}

protocol OperationEditCellViewModelDelegate: AnyObject {
  func operationEditViewModelTableViewUpdate(_ viewModel: OperationEditCellViewModel)
  func operationEditViewModelDidChangeOperationCategory(_ viewModel: OperationEditCellViewModel, text category: String)
  func operationEditViewModelDidChangeOperationAmount(_ viewModel: OperationEditCellViewModel, text amount: String)
  func operationEditViewModelDidChangeOperationDefinition(_ viewModel: OperationEditCellViewModel, text definition: String)
}

class OperationEditCellViewModel: OperationEditCellViewModelProtocol {
  // MARK: - Properties
  weak var delegate: OperationEditCellViewModelDelegate?
  
  var titleOperationCategory: String {
    return operation.name
  }
  
  var placeholderContentTextField: String {
    return type.placeholderContentTextField
  }
  
  var textContentTextField: String {
    return NSDecimalNumber(decimal: operation.amount).stringValue
  }
  
  var textMoreInfoTextView: String {
    return operation.definition ?? ""
  }
  
  var isHiddenOperationCategoryButton: Bool {
    return type.isHiddenOperationCategoryButton
  }
  
  var isHiddenContentTextField: Bool {
    return type.isHiddenContentTextField
  }
  
  var isHiddenMoreInfoTextView: Bool {
    return type.isHiddenMoreInfoTextView
  }
  
  private let operation: OperationModel
  private let type: OperationEditCellType
  
  // MARK: - Init
  init(operation: OperationModel, _ type: OperationEditCellType) {
    self.operation = operation
    self.type = type
  }
  
  // MARK: - Public methods
  func textViewDidChangeUpdateTableView() {
    delegate?.operationEditViewModelTableViewUpdate(self)
  }
  
  func categoryDidChange(_ category: String) {
    delegate?.operationEditViewModelDidChangeOperationCategory(self, text: category)
  }
  
  func amountTextFieldDidChange(_ text: String) {
    delegate?.operationEditViewModelDidChangeOperationAmount(self, text: text)
  }
  
  func definitionTextViewDidChange(_ text: String) {
    delegate?.operationEditViewModelDidChangeOperationDefinition(self, text: text)
  }
}
