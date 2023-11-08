//
//  OperationDateHeaderViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 08.11.2023.
//

import Foundation

class OperationDateHeaderViewModel {
  var date: String {
    return operationDate
  }
  
  private let operationDate: String
  
  init(operationDate: String) {
    self.operationDate = operationDate
  }
}

extension OperationDateHeaderViewModel: TableHeaderViewModel {
  var tableReuseIdentifier: String {
    return String(describing: OperationDateHeaderView.self)
  }
}
