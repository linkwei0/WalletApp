//
//  CardDetailViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 15.12.2023.
//

import Foundation

protocol CardDetailViewModelDelegate: AnyObject {
  func cardDetailViewModelDidRequestToDismiss(_ viewModel: CardDetailViewModel)
}

class CardDetailViewModel: TableViewModel {
  // MARK: - Properties
  weak var delegate: CardDetailViewModelDelegate?
  
  var onNeedsToUpdateTableView: (() -> Void)?
  
  private(set) var sectionViewModels: [TableSectionViewModel] = []
  
  private let categoryName: String
  private let operations: [OperationModel]
  
  // MARK: - Init
  init(categoryName: String, operations: [OperationModel]) {
    self.categoryName = categoryName
    self.operations = operations
    configureSectionViewModels()
  }
  
  // MARK: - Public methods
  func isFirstSection(_ section: Int) -> Bool {
    return section == 0
  }
  
  func dismiss() {
    delegate?.cardDetailViewModelDidRequestToDismiss(self)
  }
  
  // MARK: - Private methods
  private func configureSectionViewModels() {
    operationsSortedByDate()
  }
  
  private func operationsSortedByDate() {
    sectionViewModels.removeAll()
    
    let categoryHeaderViewModel = OperationHeaderViewModel(title: categoryName, type: .list, isFirstSection: false)
    let categorySection = TableSectionViewModel(headerViewModel: categoryHeaderViewModel)
    sectionViewModels.append(categorySection)
    
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
