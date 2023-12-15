//
//  OperationListViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 08.11.2023.
//

import Foundation

class OperationListViewModel: TableViewModel {
  private enum SortedTypes: String, CaseIterable {
    case byCategory = "По категориям"
    case byOperationType = "По типу операции"
    case byValue = "По убыванию"
    case byDate = "По дате"
  }
  
  // MARK: - Properties
  var onNeedsToUpdateTableView: (() -> Void)?
  
  var sortedTypesList: [String] {
    return sortedTypes.map { $0.rawValue }
  }
  
  private let sortedTypes = SortedTypes.allCases
  
  private(set) var sectionViewModels: [TableSectionViewModel] = []
  private let operations: [OperationModel]
  
  // MARK: - Init
  init(operations: [OperationModel]) {
    self.operations = operations
  }
  
  // MARK: - Public methods
  func viewIsReady() {
    operationsSortedByDate()
  }
  
  func didChangeSort(with title: String) {
    guard let sortedType = SortedTypes(rawValue: title) else { return }
    switch sortedType {
    case .byCategory:
      operationsSortedByCategory(title: sortedType.rawValue)
    case .byOperationType:
      operationsSortedByOperationType(title: sortedType.rawValue)
    case .byValue:
      operationsSortedByValue(title: sortedType.rawValue)
    case .byDate:
      operationsSortedByDate()
    }
  }
  
  // MARK: - Private methods
  private func operationsSortedByCategory(title: String) {
    sectionViewModels.removeAll()
    
    var incomeCategories: [IncomeCategoryTypes: [OperationCellViewModel]] = [:]
    var expenseCategories: [ExpenseCategoryTypes: [OperationCellViewModel]] = [:]
    operations.forEach { operation in
      let operationType = operation.type
      switch operationType {
      case .income:
        let incomeCategory = IncomeCategoryTypes(rawValue: operation.category) ?? .salary
        let cellViewModel = OperationCellViewModel(operation)
        incomeCategories[incomeCategory, default: []].append(cellViewModel)
      case .expense:
        let expenseCategory = ExpenseCategoryTypes(rawValue: operation.category) ?? .food
        let cellViewModel = OperationCellViewModel(operation)
        expenseCategories[expenseCategory, default: []].append(cellViewModel)
      }
    }
    
    for (incomeCategory, cellViewModels) in incomeCategories {
      let headerViewModel = OperationHeaderViewModel(title: incomeCategory.title, type: .list)
      let section = TableSectionViewModel(headerViewModel: headerViewModel)
      section.append(cellViewModels: cellViewModels)
      sectionViewModels.append(section)
    }
    
    for (expenseCategory, cellViewModels) in expenseCategories {
      let headerViewModel = OperationHeaderViewModel(title: expenseCategory.title, type: .list)
      let section = TableSectionViewModel(headerViewModel: headerViewModel)
      section.append(cellViewModels: cellViewModels)
      sectionViewModels.append(section)
    }
    onNeedsToUpdateTableView?()
  }
  
  private func operationsSortedByOperationType(title: String) {
    sectionViewModels.removeAll()
    let itemViewModels = operations.map { OperationCellViewModel($0) }
    let sortedByOperationType = itemViewModels.sorted { $0.isIncome && !$1.isIncome }
    let headerViewModel = OperationHeaderViewModel(title: title, type: .list)
    let section = TableSectionViewModel(headerViewModel: headerViewModel)
    section.append(cellViewModels: sortedByOperationType)
    sectionViewModels.append(section)
    onNeedsToUpdateTableView?()
  }
  
  private func operationsSortedByValue(title: String) {
    sectionViewModels.removeAll()

    let sortedByValue = operations.sorted { $0.amount > $1.amount }
    let itemViewModels = sortedByValue.map { OperationCellViewModel($0) }
    let headerViewModel = OperationHeaderViewModel(title: title, type: .list)
    let section = TableSectionViewModel(headerViewModel: headerViewModel)
    section.append(cellViewModels: itemViewModels)
    sectionViewModels.append(section)
    onNeedsToUpdateTableView?()
  }
  
  private func operationsSortedByDate() {
    sectionViewModels.removeAll()
    
    var operationsDateDict: [DateInterval: [OperationCellViewModel]] = [:]
    operations.forEach { operation in
      let itemViewModel = OperationCellViewModel(operation)
      let dateInterval = operation.date.dateInterval()
      
      if let value = operationsDateDict[dateInterval] {
        operationsDateDict[dateInterval] = value + [itemViewModel]
      } else {
        operationsDateDict[dateInterval] = [itemViewModel]
      }
    }
    
    let dateFormatter = DateFormatter.dayMonthYearDisplay
    let sortedDateInterval: [DateInterval] = Array(operationsDateDict.keys).sorted(by: >)
    for dateInterval in sortedDateInterval {
      if operationsDateDict[dateInterval]?.isEmpty == false {
        let headerOperationDate = dateFormatter.string(from: dateInterval.start)
        let headerViewModel = OperationDateHeaderViewModel(operationDate: headerOperationDate, type: .list)
        let section = TableSectionViewModel(headerViewModel: headerViewModel)
        section.append(cellViewModels: operationsDateDict[dateInterval] ?? [])
        sectionViewModels.append(section)
      }
    }
    onNeedsToUpdateTableView?()
  }
}
