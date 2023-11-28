////
////  TestDetailViewModel.swift
////  WalletApp
////
////  Created by Артём Бацанов on 28.11.2023.
////
//
//import Foundation
//
//class TestDetailViewModel: TableViewModel, SimpleViewStateProccessable {
//  // MARK: - Properties
//  var bottomBarConfiguration: WalletBottomBarConfiguration {
//    return .walletDetail
//  }
//  
//  var sectionViewModels: [TableSectionViewModel] = []
//  
//  private(set) var viewState: Bindable<SimpleViewState<OperationModel>> = Bindable(.initial)
//  
//  private var operations: [OperationModel] {
//    return viewState.value.currentEntities
//  }
//  
//  private let interactor: WalletDetailInteractorProtocol
//  private let wallet: WalletModel
//  
//  // MARK: - Init
//  init(interactor: WalletDetailInteractorProtocol, wallet: WalletModel) {
//    self.interactor = interactor
//    self.wallet = wallet
//  }
//  
//  // MARK: - Public methods
//  func viewIsReady() {
//    fetchOperations()
//  }
//  
//  func didSelectBottomBarItem(_ itemType: WalletBottomBarItemType) {
//    print("Did tap \(itemType.title)")
//  }
//  
//  // MARK: - Private methods
//  private func fetchOperations() {
//    interactor.getOperations(for: wallet.id) { result in
//      switch result {
//      case .success(let operations):
//        let sortedOperations = operations.sorted { $0.date > $1.date }
//        self.viewState.value = self.processResult(sortedOperations)
//        let operationsByDate = self.configureOperationsByDate(sortedOperations)
//        self.configureSections(operationsByDate)
//      case .failure(let error):
//        print("Failed to get operations \(error)")
//      }
//    }
//  }
//  
//  private func configureSections(_ operationsByDate: [WalletDetailCellViewModel]) {
//    sectionViewModels.removeAll()
//    operationsByDate.forEach { sectionContainer in
//      let section = TableSectionViewModel()
//      section.append(sectionContainer)
//      sectionViewModels.append(section)
//    }
//  }
//  
//  private func configureOperationsByDate(_ operations: [OperationModel]) -> [WalletDetailCellViewModel] {
//    var operationsToday = OperationSectionContainer(date: .today, opertions: [])
//    var operationsYesteraday = OperationSectionContainer(date: .yesterday, opertions: [])
//    
//    for operation in operations {
//      if operation.date.isToday() { operationsToday.opertions.append(operation) }
//      if operation.date.isYesterday() { operationsYesteraday.opertions.append(operation) }
//    }
//    
//    let sectionTodayContainer = WalletDetailCellViewModel(operations: operationsToday.opertions, dateType: .today)
//    let sectionYesterdayContainer = WalletDetailCellViewModel(operations: operationsYesteraday.opertions, dateType: .yesterday)
//
//    return [sectionTodayContainer, sectionYesterdayContainer]
//  }
//}
