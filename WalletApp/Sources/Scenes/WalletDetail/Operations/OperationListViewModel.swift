//
//  OperationListViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 08.11.2023.
//

import Foundation

class OperationListViewModel: TableViewModel {
  // MARK: - Properties
  private(set) var sectionViewModels: [TableSectionViewModel] = []
  private let operations: [OperationModel]
  
  // MARK: - Init
  init(operations: [OperationModel]) {
    self.operations = operations
  }
  
  // MARK: - Public methods
  func viewIsReady() {
    getOperations()
  }
  
  // MARK: - Private methods
  private func getOperations() {
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
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yy"
    
    var sortedDateInterval: [DateInterval] = Array(operationsDateDict.keys).sorted(by: >)
    
    for dateInterval in sortedDateInterval {
      if operationsDateDict[dateInterval]?.isEmpty == false {
        let headerOperationDate = dateFormatter.string(from: dateInterval.start)
        let headerViewModel = OperationDateHeaderViewModel(operationDate: headerOperationDate)
        let section = TableSectionViewModel(headerViewModel: headerViewModel)
        section.append(cellViewModels: operationsDateDict[dateInterval] ?? [])
        sectionViewModels.append(section)
      }
    }
  }
}
