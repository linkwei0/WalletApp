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
  func viewModelSuccessfullyCreateBudget(_ viewModel: CreateBudgetViewModel, budget: BudgetModel)
  func viewModelDidRequestToDismiss(_ viewModel: CreateBudgetViewModel)
}

class CreateBudgetViewModel: TableViewModel {
  private enum CellNumberRows {
    case amount
    case period
    case name
    case category
    
    var raw: Int {
      switch self {
      case .amount:
        return 0
      case .period:
        return 1
      case .name:
        return 2
      case .category:
        return 3
      }
    }
    
    var section: Int {
      switch self {
      case .amount, .period, .name, .category:
        return 0
      }
    }
  }
  
  // MARK: - Properties
  weak var delegate: CreateBudgetViewModelDelegate?
  
  var onNeedsUpdate: (() -> Void)?
  var onNeedsShowCalculationModalView: (() -> Void)?
  var onNeedsUpdateRow: ((IndexPath) -> Void)?
  
  let calculationModalViewModel = CalculationModalViewModel()
  
  private(set) var sectionViewModels: [TableSectionViewModel] = []
  private(set) var itemViewModels: [TableCellViewModel] = []
  
  private var currentAmount: Int = 0
  private var budgetAmountArr: [String] = []
  private var budgetModel = BudgetModel.makeCleanModel()
  
  private let walletID: Int
  private let budgetCellTypes: [CreateBudgetCellTypes] = CreateBudgetCellTypes.allCases
  private let maxBudgetLength: Int = 8
  
  private let interactor: CreateBudgetInteractorProtocol
  
  // MARK: - Init
  init(interactor: CreateBudgetInteractor, walletID: Int) {
    self.interactor = interactor
    self.walletID = walletID
    calculationModalViewModel.delegate = self
  }
  
  // MARK: - Public methods
  func viewIsReady() {
    configureSectionViewModels()
  }
  
  func didSelectPeriodOfBudget(periodType: SelectPeriodTypes) {
    let cellViewModel = CreateBudgetCellViewModel(.period, periodType: periodType)
    let periodRow = IndexPath(row: CellNumberRows.period.raw, section: CellNumberRows.period.section)
    updatePeriodBudgetModel(periodType)
    updateCellViewModel(at: periodRow, with: cellViewModel)
  }
  
  func didSelectCategoryOfBudget(expenseType: ExpenseCategoryTypes) {
    let cellViewModel = CreateBudgetCellViewModel(.category, categoryType: expenseType)
    let categoryRow = IndexPath(row: CellNumberRows.category.raw, section: CellNumberRows.category.section)
    updateCategoryBudgetModel(expenseType)
    updateCellViewModel(at: categoryRow, with: cellViewModel)
  }
  
  func didTapCreateButton() {
    if !budgetAmountArr.isEmpty && !budgetModel.name.isEmpty && budgetModel.endPeriod != nil {
      let maxAmount = Decimal(string: budgetAmountArr.joined()) ?? 0
      budgetModel.maxAmount = maxAmount
      budgetModel.walletID = walletID
      interactor.saveBudget(for: walletID, budget: budgetModel) { result in
        switch result {
        case .success:
          self.delegate?.viewModelSuccessfullyCreateBudget(self, budget: self.budgetModel)
        case .failure(let error):
          print("Failed to save budget with error - \(error)")
        }
      }
    }
  }
  
  func dismiss() {
    delegate?.viewModelDidRequestToDismiss(self)
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
    
    let itemViewModel = NotificationSwitcherCellViewModel()
    itemViewModel.delegate = self
    let section = TableSectionViewModel()
    section.append(itemViewModel)
    sectionViewModels.append(section)
    
    onNeedsUpdate?()
  }
  
  private func updateCategoryBudgetModel(_ expenseType: ExpenseCategoryTypes) {
    budgetModel.category = expenseType
  }
  
  private func updatePeriodBudgetModel(_ period: SelectPeriodTypes) {
    let beginDate = Date()
    let endDate: Date?
    switch period {
    case .weekly:
      endDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: beginDate)
    case .monthly:
      endDate = Calendar.current.date(byAdding: .month, value: 1, to: beginDate)
    }
    budgetModel.beginPeriod = beginDate
    budgetModel.endPeriod = endDate
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
  
  func cellViewModelDidRequestToUpdateName(_ viewModel: CreateBudgetCellViewModel, with text: String) {
    budgetModel.name = text
  }
}

// MARK: - CalculationModalViewModelDelegate
extension CreateBudgetViewModel: CalculationModalViewModelDelegate {
  func viewModelDidRequestToChangeAmount(_ viewModel: CalculationModalViewModel, amount: String) {
    if !budgetAmountArr.isEmpty && budgetAmountArr[0] == "0" { return } //|| budgetAmountArr[1] != "." { return }
    if budgetAmountArr.count < maxBudgetLength {
      budgetAmountArr.append(amount)
      let cellViewModel = CreateBudgetCellViewModel(.amount, budgetAmountArr: budgetAmountArr)
      let amountBudgetRow = IndexPath(row: CellNumberRows.amount.raw, section: CellNumberRows.amount.section)
      updateCellViewModel(at: amountBudgetRow, with: cellViewModel)
    }
  }
  
  func viewModelDidRequestToPreviousValue(_ viewModel: CalculationModalViewModel) {
    if !budgetAmountArr.isEmpty {
      budgetAmountArr.removeLast()
      let cellViewModel = CreateBudgetCellViewModel(.amount, budgetAmountArr: budgetAmountArr)
      let amountBudgetRow = IndexPath(row: CellNumberRows.amount.raw, section: CellNumberRows.amount.section)
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
    let amountBudgetRow = IndexPath(row: CellNumberRows.amount.raw, section: CellNumberRows.amount.section)
    updateCellViewModel(at: amountBudgetRow, with: cellViewModel)
  }
}

// MARK: - NotificationSwitcherCellViewModelDelegate
extension CreateBudgetViewModel: NotificationSwitcherCellViewModelDelegate {
  func cellViewModelDidChangeSwitcher(_ viewModel: NotificationSwitcherCellViewModel, isOn: Bool) {
    budgetModel.isNotifiable = isOn
  }
}
