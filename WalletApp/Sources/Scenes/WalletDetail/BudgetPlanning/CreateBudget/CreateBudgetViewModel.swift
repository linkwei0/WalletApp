//
//  CreateBudgetViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 15.11.2023.
//

import Foundation

protocol CreateBudgetViewModelDelegate: AnyObject {
  func viewModelDidRequestToShowSelectPeriodScreen(_ viewModel: CreateBudgetViewModel)
  func viewModelDidRequestToShowSelectCategoryScreen(_ viewModel: CreateBudgetViewModel)
}

class CreateBudgetViewModel: TableViewModel {
  // MARK: - Properties
  weak var delegate: CreateBudgetViewModelDelegate?
  
  var onNeedsUpdate: (() -> Void)?
  var onNeedsShowCalculationModalView: (() -> Void)?
  var onNeedsUpdateRow: ((IndexPath) -> Void)?
  
  let calculationModalViewModel = CalculationModalViewModel()
  
  private(set) var sectionViewModels: [TableSectionViewModel] = []
  private(set) var itemViewModels: [TableCellViewModel] = []
  
  private var budgetAmountArr: [String] = []
  
  private let budgetCellTypes: [CreateBudgetCellTypes] = CreateBudgetCellTypes.allCases
  private let maxBudgetLength: Int = 8
  
  // MARK: - Init
  init() {
    calculationModalViewModel.delegate = self
  }
  
  // MARK: - Public methods
  func viewIsReady() {
    configureSectionViewModels()
  }
  
  func didSelectPeriodOfBudget(periodType: SelectPeriodTypes) {
    let cellViewModel = CreateBudgetCellViewModel(.period, periodType: periodType)
    let periodRow = IndexPath(row: 1, section: 0)
    updateCellViewModel(at: periodRow, with: cellViewModel)
  }
  
  func didSelectCategoryOfBudget(expeseType: ExpenseCategoryTypes) {
    let cellViewModel = CreateBudgetCellViewModel(.category, categoryType: expeseType)
    let categoryRow = IndexPath(row: 3, section: 0)
    updateCellViewModel(at: categoryRow, with: cellViewModel)
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
  
  deinit {
    print("VM")
  }
  
  private func updateCellViewModel(at indexPath: IndexPath, with cellViewModel: CreateBudgetCellViewModel) {
    cellViewModel.delegate = self
    sectionViewModels[indexPath.section].update(at: indexPath.row, with: cellViewModel)
    onNeedsUpdateRow?(indexPath)
  }
}

// MARK: - CreateBudgetCellViewModelDelegate
extension CreateBudgetViewModel: CreateBudgetCellViewModelDelegate {
  func cellViewModelDidRequestToShowModalBottomView(_ viewModel: CreateBudgetCellViewModel) {
    onNeedsShowCalculationModalView?()
  }
  
  func cellViewModelDidRequestToSelectPeriodScreen(_ viewModel: CreateBudgetCellViewModel) {
    delegate?.viewModelDidRequestToShowSelectPeriodScreen(self)
  }
  
  func cellViewModelDidRequestToSelectCategoryScreen(_ viewModel: CreateBudgetCellViewModel) {
    delegate?.viewModelDidRequestToShowSelectCategoryScreen(self)
  }
}

// MARK: - CalculationModalViewModelDelegate
extension CreateBudgetViewModel: CalculationModalViewModelDelegate {
  func viewModelDidRequestToChangeAmount(_ viewModel: CalculationModalViewModel, amount: String) {
    if !budgetAmountArr.isEmpty && budgetAmountArr[0] == "0" { return } //|| budgetAmountArr[1] != "." { return }
    if budgetAmountArr.count < maxBudgetLength {
      budgetAmountArr.append(amount)
      let cellViewModel = CreateBudgetCellViewModel(.amount, budgetAmountArr: budgetAmountArr)
      let amountBudgetRow = IndexPath(row: 0, section: 0)
      updateCellViewModel(at: amountBudgetRow, with: cellViewModel)
    }
  }
  
  func viewModelDidRequestToPreviousValue(_ viewModel: CalculationModalViewModel) {
    if !budgetAmountArr.isEmpty {
      budgetAmountArr.removeLast()
      let cellViewModel = CreateBudgetCellViewModel(.amount, budgetAmountArr: budgetAmountArr)
      let amountBudgetRow = IndexPath(row: 0, section: 0)
      updateCellViewModel(at: amountBudgetRow, with: cellViewModel)
    }
  }
  
  func viewModelDidToRequestPoint(_ viewModel: CalculationModalViewModel) {
    if budgetAmountArr.isEmpty {
      budgetAmountArr.append("0.")
    } else if !budgetAmountArr.isEmpty && !budgetAmountArr.contains(".") {
      budgetAmountArr.append(".")
    }
    let cellViewModel = CreateBudgetCellViewModel(.amount, budgetAmountArr: budgetAmountArr)
    let amountBudgetRow = IndexPath(row: 0, section: 0)
    updateCellViewModel(at: amountBudgetRow, with: cellViewModel)
  }
}
