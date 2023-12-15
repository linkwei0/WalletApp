//
//  OperationDateHeaderViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 08.11.2023.
//

import UIKit

class OperationDateHeaderViewModel {
  var date: String {
    return operationDate
  }
  
  var titleFont: UIFont? {
    return type == .common ? .bodyBold : .header2
  }
  
  private let operationDate: String
  private let type: OperationHeaderTypes
  
  init(operationDate: String, type: OperationHeaderTypes) {
    self.operationDate = operationDate
    self.type = type
  }
}

extension OperationDateHeaderViewModel: TableHeaderViewModel {
  var tableReuseIdentifier: String {
    return String(describing: OperationDateHeaderView.self)
  }
}
