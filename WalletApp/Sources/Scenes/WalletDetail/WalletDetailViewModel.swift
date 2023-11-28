//
//  WalletDetailViewModel.swift
//  WalletApp
//

import UIKit

protocol WalletDetailViewModelDelegate: AnyObject {
  func walletDetailViewModelDidRequestToShowIncome(_ viewModel: WalletDetailViewModel, wallet: WalletModel)
  func walletDetailViewModelDidRequestToShowExpense(_ viewModel: WalletDetailViewModel, wallet: WalletModel)
  func walletDetailViewModelDidRequestToShowProfile(_ viewModel: WalletDetailViewModel)
  func walletDetailViewModelDidRequestToShowOperationEdit(_ viewModel: WalletDetailViewModel,
                                                          wallet: WalletModel, operation: OperationModel)
  func walletDetailViewModelDidRequestToShowOperationsScreen(_ viewModel: WalletDetailViewModel, operations: [OperationModel])
}

class WalletDetailViewModel: TableViewModel, SimpleViewStateProccessable {
  // MARK: - Properties
  weak var delegate: WalletDetailViewModelDelegate?
  
  var bottomBarConfiguration: WalletBottomBarConfiguration {
    return .walletDetail
  }
  
  let balanceViewModel = BalanceViewModel()
  
  private(set) var viewState: Bindable<SimpleViewState<OperationModel>> = Bindable(.initial)
  
  private(set) var sectionViewModels: [TableSectionViewModel] = []
  private(set) var emptyStateViewModel: EmptyStateViewModel?
  
  private var operations: [OperationModel] {
    return viewState.value.currentEntities
  }
  
  private var wallet: WalletModel
  private let interactor: WalletDetailInteractor
  
  private let firstDaysTo: Int = 4
  private let isPositiveNumbers: Int = 0
  
  // MARK: - Init
  init(interactor: WalletDetailInteractor, wallet: WalletModel) {
    self.interactor = interactor
    self.wallet = wallet
  }
  
  // MARK: - Public methods
  func viewIsReady() {
    fetchOperations()
  }
  
  func updateWallet() {
    setWallet()
    fetchOperations()
  }
  
  func didSelectBottomBarItem(_ itemType: WalletBottomBarItemType) {
    switch itemType {
    case .income:
      delegate?.walletDetailViewModelDidRequestToShowIncome(self, wallet: wallet)
    case .expense:
      delegate?.walletDetailViewModelDidRequestToShowExpense(self, wallet: wallet)
    case .profile:
      delegate?.walletDetailViewModelDidRequestToShowProfile(self)
    }
  }
  
  func isLastSection(_ section: Int) -> Bool {
    return sectionViewModels.count - 1 == section
  }
  
  // MARK: - Private methods
  private func setWallet() {
    interactor.getWallet(by: wallet.id) { result in
      switch result {
      case .success(let wallet):
        self.wallet = wallet
      case .failure(let error):
        print("Failed to get wallet by id with \(error)")
      }
    }
  }
  
  private func fetchOperations() {
    interactor.getOperations(for: wallet.id) { result in
      switch result {
      case .success(let operations):
        let sortedOperations = operations.sorted { $0.date > $1.date }
        self.viewState.value = self.processResult(sortedOperations)
        let operationsByDate = self.configureOperationsByDate(sortedOperations)
        self.configureSections(operationsByDate)
        self.configureBalanceModel(with: sortedOperations)
        if operations.isEmpty {
          self.emptyStateViewModel = EmptyStateViewModel(image: UIImage(systemName: Constants.emptyImage),
                                                         imageSize: CGSize(width: 120, height: 120),
                                                         title: R.string.walletDetail.walletDetailEmptyViewTitle(),
                                                         subtitle: R.string.walletDetail.walletDetailEmptyViewSubtitle())
        }
      case .failure(let error):
        print("Failed to get operations \(error)")
      }
    }
  }
  
  private func configureSections(_ operationsByDate: [WalletDetailCellViewModel]) {
    sectionViewModels.removeAll()
    
    sectionViewModels.removeAll()
    operationsByDate.forEach { sectionContainer in
      let section = TableSectionViewModel()
      section.append(sectionContainer)
      sectionViewModels.append(section)
    }
    let footerViewModel = OperationLastSectionFooterViewModel(operations: operations)
    let headerViewModel = OperationHeaderViewModel(title: R.string.walletDetail.monthCardViewTopMonthTitle())
    let section = TableSectionViewModel(headerViewModel: headerViewModel, footerViewModel: footerViewModel)
    sectionViewModels.append(section)    
    }
  
  private func configureOperationsByDate(_ operations: [OperationModel]) -> [WalletDetailCellViewModel] {
    var operationsToday = OperationSectionContainer(date: .today, opertions: [])
    var operationsYesteraday = OperationSectionContainer(date: .yesterday, opertions: [])
    
    for operation in operations {
      if operation.date.isToday() { operationsToday.opertions.append(operation) }
      if operation.date.isYesterday() { operationsYesteraday.opertions.append(operation) }
    }
    let testDetailCellViewModelTODAY = WalletDetailCellViewModel(operations: operationsToday.opertions, dateType: .today)
    let testDetailCellViewModelYESTERDAY = WalletDetailCellViewModel(operations: operationsYesteraday.opertions, dateType: .yesterday)

    return [testDetailCellViewModelTODAY, testDetailCellViewModelYESTERDAY]
  }
  
  private func configureBalanceModel(with operations: [OperationModel]) {
    balanceViewModel.updateBalance(titleBalance: R.string.balance.balanceViewWalletTotalTitle(),
                                   titleIncome: R.string.balance.balanceViewWalletIncomeTitle(),
                                   titleExpense: R.string.balance.balanceViewWalletExpenseTitle(),
                                   totalBalance: wallet.balance,
                                   totalIncome: wallet.totalEarned,
                                   totalExpense: wallet.totalSpent,
                                   currencyCode: wallet.currency.code)
  }
}

// MARK: - OperationCellViewModelDelegate
extension WalletDetailViewModel: OperationCellViewModelDelegate {
  func operationCellViewModel(_ viewModel: OperationCellViewModel, didSelect operation: OperationModel) {
    delegate?.walletDetailViewModelDidRequestToShowOperationEdit(self, wallet: wallet, operation: operation)
  }
}

// MARK: - OperationDefaultFooterViewModelDelegate
extension WalletDetailViewModel: OperationDefaultFooterViewModelDelegate {
  func defaultFooterViewModelDidTapMoreOperations(_ viewModel: OperationDefaultFooterViewModel) {
    delegate?.walletDetailViewModelDidRequestToShowOperationsScreen(self, operations: operations)
  }
}

struct OperationSectionContainer {
  let date: OperationDateType
  var opertions: [OperationModel]
}

private extension Constants {
  static let emptyImage = "exclamationmark.circle.fill"
}
