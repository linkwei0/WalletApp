//
//  IncomeViewModel.swift
//  WalletApp
//

import Foundation

protocol IncomeViewModelDelegate: AnyObject {
  func incomeViewModelDidRequestToShowCategoryView(_ viewModel: IncomeViewModel, interactor: CalculationInteractorProtocol,
                                                   wallet: WalletModel, totalValue: String)
}

final class IncomeViewModel {
  // MARK: - Properties
  weak var delegate: IncomeViewModelDelegate?
  
  var onDidCreatedOperation: (() -> Void)?
  
  private(set) var calculationViewModel: CalculationViewModel
  
  private let wallet: WalletModel
  private let interactor: CalculationInteractorProtocol

  // MARK: - Init
  init(interactor: CalculationInteractorProtocol, wallet: WalletModel) {
    self.interactor = interactor
    self.wallet = wallet
    self.calculationViewModel = CalculationViewModel(interactor: interactor, wallet: wallet, collectionType: .income)
    calculationViewModel.categoryDelegate = self
  }
}

// MARK: - CalculationViewModelCategoryDelegate
extension IncomeViewModel: CalculationViewModelCategoryDelegate {
  func calculationViewModelDidRequestToShowCategoryView(_ viewModel: CalculationViewModel,
                                                        wallet: WalletModel, totalValue: String) {
    delegate?.incomeViewModelDidRequestToShowCategoryView(self, interactor: interactor,
                                                          wallet: wallet, totalValue: totalValue)
  }
}
