//
//  BudgetPlanningHeaderView.swift
//  WalletApp
//
//  Created by Артём Бацанов on 23.11.2023.
//

import UIKit

class BudgetPlanningHeaderView: UITableViewHeaderFooterView, TableHeaderView {
  // MARK: - Properties
  private let titleLabel = Label(textStyle: .header1)
  
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
  func configure(with viewModel: TableHeaderViewModel) {
    guard let viewModel = viewModel as? BudgetPlanninHeaderViewModel else { return }
    titleLabel.text = viewModel.text
  }
  
  // MARK: - Setup
  private func setup() {
    setupTitleLabel()
  }
  
  private func setupTitleLabel() {
    contentView.addSubview(titleLabel)
    titleLabel.textColor = .baseBlack
    titleLabel.textAlignment = .center
    titleLabel.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.leading.trailing.equalToSuperview().inset(16)
    }
  }
}
