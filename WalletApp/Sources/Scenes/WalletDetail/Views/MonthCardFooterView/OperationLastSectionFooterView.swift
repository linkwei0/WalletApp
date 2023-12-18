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
  
  override func layoutSubviews() {
    super.layoutSubviews()
    showCardsAnimation()
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
    expenseCardMonthView.alpha = 1
    incomeCardMonthView.alpha = 1
    [expenseCardMonthView, incomeCardMonthView].forEach { stackView.addArrangedSubview($0) }
    stackView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(12)
      make.top.equalToSuperview().inset(10)
      make.height.equalTo(80)
    }
  }
  
  // MARK: - Private methods
  private func showCardsAnimation() {
    let expenseCardView = stackView.arrangedSubviews[0]
    let incomeCardView = stackView.arrangedSubviews[1]
    
    let animationExpenseCard = CABasicAnimation(keyPath: Constants.positionXAnimation)
    animationExpenseCard.fromValue = -expenseCardView.bounds.width
    animationExpenseCard.toValue = expenseCardView.bounds.width / 2
    animationExpenseCard.duration = 0.5
    expenseCardView.layer.add(animationExpenseCard, forKey: Constants.expenseNameAnimation)
    
    let animationIncomeCard = CABasicAnimation(keyPath: Constants.positionXAnimation)
    animationIncomeCard.fromValue = incomeCardView.bounds.width * 2 + 200
    animationIncomeCard.toValue = incomeCardView.bounds.width / 2 + 190
    animationIncomeCard.duration = 0.5
    incomeCardView.layer.add(animationIncomeCard, forKey: Constants.incomeNameAnimation)
  }
}

// MARK: - Constants
private extension Constants {
  static let expenseNameAnimation = "expenseCard"
  static let incomeNameAnimation = "incomeCard"
  static let positionXAnimation = "position.x"
}
