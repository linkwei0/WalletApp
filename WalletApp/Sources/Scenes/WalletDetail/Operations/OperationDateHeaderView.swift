//
//  OperationDateHeaderView.swift
//  WalletApp
//
//  Created by Артём Бацанов on 08.11.2023.
//

import UIKit

class OperationDateHeaderView: UITableViewHeaderFooterView, TableHeaderView {
  // MARK: - Properties
  private let operationDateLabel = Label(textStyle: .bodyBold)
  
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
    guard let viewModel = viewModel as? OperationDateHeaderViewModel else { return }
    operationDateLabel.text = viewModel.date
  }
  
  // MARK: - Setup
  private func setup() {
    setupOperationDateLabel()
  }
  
  private func setupOperationDateLabel() {
    contentView.addSubview(operationDateLabel)
    operationDateLabel.textAlignment = .left
    operationDateLabel.textColor = .baseBlack
    operationDateLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(16)
      make.top.bottom.equalToSuperview().inset(8)
    }
  }
}
