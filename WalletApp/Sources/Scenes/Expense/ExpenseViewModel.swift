//
//  ExpenseViewModel.swift
//  WalletApp
//

import Foundation

protocol ExpenseViewModelDelegate: AnyObject {
  func expenseViewModelDidRequestToShowCategoryView(_ viewModel: ExpenseViewModel, interactor: CalculationInteractorProtocol,
                                                    wallet: WalletModel, operation: OperationModel)
  func expenseViewModelDidRequestToBackWalletDetail(_ viewModel: ExpenseViewModel)
}

class ExpenseViewModel {
  // MARK: - Properties
  weak var delegate: ExpenseViewModelDelegate?
  
  var onDidCreatedOperation: ((_ wallet: WalletModel) -> Void)?
  
  private(set) var calculationViewModel: CalculationViewModel
  
  private let wallet: WalletModel
  private let interactor: CalculationInteractorProtocol
  
  // MARK: - Init
  init(interactor: CalculationInteractorProtocol, wallet: WalletModel) {
    self.interactor = interactor
    self.wallet = wallet
    self.calculationViewModel = CalculationViewModel(interactor: interactor, wallet: wallet, collectionType: .expense)
    calculationViewModel.calculationCategoryDelegate = self
  }
  
  // MARK: - Public methods
  func backToWalletDetail() {
    delegate?.expenseViewModelDidRequestToBackWalletDetail(self)
  }
}

// MARK: - CalculationViewModelCategoryDelegate
extension ExpenseViewModel: CalculationViewModelCategoryDelegate {
  func calculationViewModelDidRequestToShowCategoryView(_ viewModel: CalculationViewModel, wallet: WalletModel,
                                                        operation: OperationModel) {
    delegate?.expenseViewModelDidRequestToShowCategoryView(self, interactor: interactor, wallet: wallet,
                                                           operation: operation)
  }
}
