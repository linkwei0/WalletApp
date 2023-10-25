//
//  IncomeViewModel.swift
//  WalletApp
//

import Foundation

protocol IncomeViewModelDelegate: AnyObject {
  func incomeViewModelDidRequestToShowCategoryView(_ viewModel: IncomeViewModel)
}

final class IncomeViewModel {
  // MARK: - Properties
  weak var delegate: IncomeViewModelDelegate?
  
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
  
  func didSelectCategory(_ category: String) {
    print("Selected -", category)
  }
}

// MARK: - CalculationViewModelCategoryDelegate
extension IncomeViewModel: CalculationViewModelCategoryDelegate {
  func calculationViewModelDidRequestToShowCategoryView(_ viewModel: CalculationViewModel) {
    delegate?.incomeViewModelDidRequestToShowCategoryView(self)
  }
}
