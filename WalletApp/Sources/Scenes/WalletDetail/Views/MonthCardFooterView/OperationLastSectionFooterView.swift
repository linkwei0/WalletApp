//
//  OperationFooterView.swift
//  WalletApp
//
//  Created by Артём Бацанов on 07.11.2023.
//

import UIKit

class OperationLastSectionFooterView: UITableViewHeaderFooterView, TableFooterView {
  // MARK: - Properties
  private let stackView = UIStackView()
  private let expenseCardMonthView = OperationMonthCardView()
  private let incomeCardMonthView = OperationMonthCardView()
  
  // MARK: - Init
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  // MARK: - Configure
  func configure(with viewModel: TableFooterViewModel) {
    guard let viewModel = viewModel as? OperationLastSectionFooterViewModel else { return }
    incomeCardMonthView.configure(with: viewModel.incomeCardViewModel)
    expenseCardMonthView.configure(with: viewModel.expenseCardViewModel)
  }
  
  // MARK: - Setup
  private func setup() {
    setupStackView()
  }
  
  private func setupStackView() {
    addSubview(stackView)
    stackView.axis = .horizontal
    stackView.spacing = 8
    stackView.distribution = .fillEqually
    [expenseCardMonthView, incomeCardMonthView].forEach { stackView.addArrangedSubview($0) }
    stackView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(12)
      make.top.equalToSuperview()
      make.height.equalTo(80)
    }
  }
}
