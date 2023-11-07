//
//  IncomeViewModel.swift
//  WalletApp
//

import Foundation

protocol IncomeViewModelDelegate: AnyObject {
  func incomeViewModelDidRequestToShowCategoryView(_ viewModel: IncomeViewModel, interactor: CalculationInteractorProtocol,
                                                   wallet: WalletModel, operation: OperationModel)
  func incomeViewModelDidRequestToBackWalletDetail(_ viewModel: IncomeViewModel)
}

final class IncomeViewModel {
  // MARK: - Properties
  weak var delegate: IncomeViewModelDelegate?
  
  var onDidCreateOperation: ((_ wallet: WalletModel) -> Void)?
  
  private(set) var calculationViewModel: CalculationViewModel
  
  private let wallet: WalletModel
  private let interactor: CalculationInteractorProtocol

  // MARK: - Init
  init(interactor: CalculationInteractorProtocol, wallet: WalletModel) {
    self.interactor = interactor
    self.wallet = wallet
    self.calculationViewModel = CalculationViewModel(interactor: interactor, wallet: wallet, collectionType: .income)
    calculationViewModel.calculationCategoryDelegate = self
  }
  
  // MARK: - Public methods
  func backToWalletDetail() {
    delegate?.incomeViewModelDidRequestToBackWalletDetail(self)
  }
}

// MARK: - CalculationViewModelCategoryDelegate
extension IncomeViewModel: CalculationViewModelCategoryDelegate {
  func calculationViewModelDidRequestToShowCategoryView(_ viewModel: CalculationViewModel, wallet: WalletModel,
                                                        operation: OperationModel) {
    delegate?.incomeViewModelDidRequestToShowCategoryView(self, interactor: interactor, wallet: wallet,
                                                          operation: operation)
  }
}
