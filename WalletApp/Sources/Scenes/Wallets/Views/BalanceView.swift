//
//  BalanceView.swift
//  WalletApp
//

import UIKit

class BalanceView: UIView {
  // MARK: - Properties
  private let titleBalanceLabel = Label(textStyle: .footnote)
  private let balanceLabel = Label(textStyle: .header1)
  private let titleIncomeLabel = Label(textStyle: .footnote)
  private let incomeLabel = Label(textStyle: .bodyBold)
  private let titleExpenseLabel = Label(textStyle: .footnote)
  private let expenseLabel = Label(textStyle: .bodyBold)
  
  private let viewModel: BalanceViewModel
  
  // MARK: - Init
  init(viewModel: BalanceViewModel) {
    self.viewModel = viewModel
    super.init(frame: .zero)
    setup()
    setupBindables()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    cornerRadius(usingCorner: [.bottomLeft, .bottomRight], cornerRadius: CGSize(width: 12, height: 12))
  }
    
  // MARK: - Private methods
  private func setup() {
    setupBackground()
    setupLabels()
    setupStackViews()
  }
  
  private func setupBackground() {
    backgroundColor = .accent
  }
  
  private func setupLabels() {
    titleBalanceLabel.textColor = .baseWhite
    balanceLabel.textColor = .baseWhite
    
    titleIncomeLabel.textColor = .incomeBtnColor
    incomeLabel.textColor = .incomeBtnColor
    
    titleExpenseLabel.textColor = .expenseBtnColor
    expenseLabel.textColor = .expenseBtnColor
  }
  
  private func setupStackViews() {
    let totalStackView = configureStackView(titleBalanceLabel, balanceLabel)
    let expenseStackView = configureStackView(titleExpenseLabel, expenseLabel)
    let incomeStackView = configureStackView(titleIncomeLabel, incomeLabel)
    
    let bottomStackView = UIStackView()
    bottomStackView.axis = .horizontal
    bottomStackView.distribution = .fillEqually
    bottomStackView.spacing = 120
    bottomStackView.addArrangedSubview(incomeStackView)
    bottomStackView.addArrangedSubview(expenseStackView)
    
    let stackView = configureStackView(totalStackView, bottomStackView)
    addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(16)
      make.leading.equalToSuperview().inset(16)
    }
  }
  
  func configureStackView(_ topView: UIView, _ bottomView: UIView) -> UIStackView {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 8
    stackView.addArrangedSubview(topView)
    stackView.addArrangedSubview(bottomView)
    return stackView
  }
  
  // MARK: - Bindables
  private func setupBindables() {
    viewModel.balance.bind { balance in
      self.titleBalanceLabel.text = balance.titleBalance
      self.titleIncomeLabel.text = balance.titleIncome
      self.titleExpenseLabel.text = balance.titleExpense
      self.balanceLabel.text = "\(balance.totalBalance)" + balance.currency
      self.incomeLabel.text = "\(balance.totalIncome)" + balance.currency
      self.expenseLabel.text = (balance.totalExpense > 0 ? "-\(balance.totalExpense)" 
                                : "\(balance.totalExpense)") + balance.currency
    }
  }
}
