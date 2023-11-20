//
//  CreateBudgetViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 15.11.2023.
//

import Foundation

enum CreateBudgetCellType: CaseIterable {
  case amount, period, name, category
  
  var text: String {
    switch self {
    case .amount:
      return ""
    case .period:
      return "Выберите период"
    case .name:
      return "Введите название"
    case .category:
      return "Выберите категорию"
    }
  }
  
  var isAmountContainerView: Bool {
    switch self {
    case .amount:
      return true
    case .period, .name, .category:
      return false
    }
  }
}

class CreateBudgetViewModel: TableViewModel {
  // MARK: - Properties
  var onNeedsUpdate: (() -> Void)?
  var onNeedsShowCalculationModalView: (() -> Void)?
  var onNeedsUpdateRow: ((IndexPath) -> Void)?
  
  let calculationModalViewModel = CalculationModalViewModel()
  
  private(set) var sectionViewModels: [TableSectionViewModel] = []
  private(set) var itemViewModels: [TableCellViewModel] = []
  
  private var budgetAmountArr: [String] = []
  
  private let budgetCellTypes: [CreateBudgetCellType] = CreateBudgetCellType.allCases
  
  // MARK: - Init
  init() {
    calculationModalViewModel.delegate = self
  }
  
  // MARK: - Public methods
  func viewIsReady() {
    configureSectionViewModels()
  }
  
  // MARK: - Private methods
  private func configureSectionViewModels() {
    itemViewModels = budgetCellTypes.map { type in
      let itemViewModel = CreateBudgetCellViewModel(type)
      itemViewModel.delegate = self
      return itemViewModel
    }
    
    if !itemViewModels.isEmpty {
      let section = TableSectionViewModel()
      section.append(cellViewModels: itemViewModels)
      sectionViewModels.append(section)
    }
    onNeedsUpdate?()
  }
  
  func updateCellViewModel(at indexPath: IndexPath, with cellViewModel: CreateBudgetCellViewModel) {
    sectionViewModels[indexPath.section].update(at: indexPath.row, with: cellViewModel)
    onNeedsUpdateRow?(indexPath)
  }
}

// MARK: - CreateBudgetCellViewModelDelegate
extension CreateBudgetViewModel: CreateBudgetCellViewModelDelegate {
  func cellViewModelDidRequestToShowModalBottomView(_ viewModel: CreateBudgetCellViewModel) {
    onNeedsShowCalculationModalView?()
  }
}

// MARK: - CalculationModalViewModelDelegate
extension CreateBudgetViewModel: CalculationModalViewModelDelegate {
  func viewModelDidRequestToChangeAmount(_ viewModel: CalculationModalViewModel, amount: String) {
    if !budgetAmountArr.isEmpty && budgetAmountArr[0] == "0" { return } //|| budgetAmountArr[1] != "." { return }
    if budgetAmountArr.count < 8 {
      budgetAmountArr.append(amount)
      let cellViewModel = CreateBudgetCellViewModel(.amount, budgetAmountArr: budgetAmountArr)
      updateCellViewModel(at: IndexPath(row: 0, section: 0), with: cellViewModel)
    }
  }
  
  func viewModelDidRequestToPreviousValue(_ viewModel: CalculationModalViewModel) {
    if !budgetAmountArr.isEmpty {
      budgetAmountArr.removeLast()
      let cellViewModel = CreateBudgetCellViewModel(.amount, budgetAmountArr: budgetAmountArr)
      updateCellViewModel(at: IndexPath(row: 0, section: 0), with: cellViewModel)
    }
  }
  
  func viewModelDidToRequestPoint(_ viewModel: CalculationModalViewModel) {
    if budgetAmountArr.isEmpty {
      budgetAmountArr.append("0.")
    } else if !budgetAmountArr.isEmpty && !budgetAmountArr.contains(".") {
      budgetAmountArr.append(".")
    }
    let cellViewModel = CreateBudgetCellViewModel(.amount, budgetAmountArr: budgetAmountArr)
    updateCellViewModel(at: IndexPath(row: 0, section: 0), with: cellViewModel)
  }
}
