//
//  OperationEditViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 31.10.2023.
//

import Foundation

protocol OperationEditViewModelDelegate: AnyObject {
  func operationEditViewModelSuccessfullyEditedOperation(_ viewModel: OperationEditViewModel)
  func operationEditViewModelDidRequestToShowCategoryScreen(_ viewModel: OperationEditViewModel, wallet: WalletModel,
                                                            operation: OperationModel)
}

class OperationEditViewModel {
  // MARK: - Properties
  weak var delegate: OperationEditViewModelDelegate?
  
  var cellViewModels: [OperationEditCellViewModelProtocols] {
    return operationEditType.compactMap { type in
      let cellViewModel = OperationEditCellViewModel(with: operation, type: type, currencyCode: wallet.currency.code)
      cellViewModel.delegate = self
      return cellViewModel
    }
  }
  
  var onDidUpdateOperationCategory: ((_ wallet: WalletModel, _ operation: OperationModel) -> Void)?
  var onNeedsToUpdateDataSource: (() -> Void)?
    
  private var wallet: WalletModel
  private var operation: OperationModel
  
  private let currentOperationAmount: Decimal
  private let operationEditType: [OperationEditCellType] = [.category, .amount, .info]
  private let interactor: OperationEditInteractor
  
  // MARK: - Init
  init(interactor: OperationEditInteractor, wallet: WalletModel, operation: OperationModel) {
    self.interactor = interactor
    self.wallet = wallet
    self.operation = operation
    self.currentOperationAmount = operation.amount
  }
  
  // MARK: - Public methods
  func didTapEditOperation() {
    changeWalletValues()
    interactor.editOperation(for: wallet, operation: operation) { result in
      switch result {
      case .success:
        self.delegate?.operationEditViewModelSuccessfullyEditedOperation(self)
      case .failure(let error):
        print("Failed to edited operation with \(error)")
      }
    }
  }
  
  func didSelectRow(at row: Int) {
    if operationEditType[row] == .category {
      delegate?.operationEditViewModelDidRequestToShowCategoryScreen(self, wallet: wallet, operation: operation)
    }
  }
  
  func updateOperation(for wallet: WalletModel, with operation: OperationModel) {
    self.operation = operation
    onNeedsToUpdateDataSource?()
  }
  
  // MARK: - Private methods
  private func changeWalletValues() {
    if operation.type.isIncome {
      wallet.balance -= currentOperationAmount
      wallet.totalEarned -= currentOperationAmount
      wallet.balance += operation.amount
      wallet.totalEarned += operation.amount
    } else {
      wallet.balance += currentOperationAmount
      wallet.totalSpent -= currentOperationAmount
      wallet.balance -= operation.amount
      wallet.totalSpent += operation.amount
    }
  }
}

// MARK: - OperationEditCellViewModelDelegate
extension OperationEditViewModel: OperationEditCellViewModelDelegate {
  func operationEditViewModelDidChangeOperationCategory(_ viewModel: OperationEditCellViewModel, text category: String) {
    operation.category = category
  }
  
  func operationEditViewModelDidChangeOperationAmount(_ viewModel: OperationEditCellViewModel, text amount: String) {
    operation.amount = Decimal(string: amount) ?? operation.amount
  }
  
  func operationEditViewModelDidChangeOperationDefinition(_ viewModel: OperationEditCellViewModel, text definition: String) {
    operation.definition = definition
  }
}
