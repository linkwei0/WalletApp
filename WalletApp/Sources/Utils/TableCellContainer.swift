//
//  TableCellContainer.swift
//  WalletApp
//
//  Created by Артём Бацанов on 29.11.2023.
//

import UIKit

class TableCellContainer<ItemView: UIView>: UITableViewCell, TableCell where ItemView: Configurable {
  // MARK: - Properties
  private let itemView = ItemView()
  
  // MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  // MARK: - Configure
  func configure(with viewModel: TableCellViewModel) {
    if let viewModel = viewModel as? ItemView.ViewModel {
      itemView.configure(with: viewModel)
    }
  }
  
  // MARK: - Setup
  private func setup() {
    contentView.addSubview(itemView)
    backgroundColor = .clear
    itemView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    selectionStyle = .none
  }
}

protocol Configurable {
  associatedtype ViewModel
  func configure(with viewModel: ViewModel)
}

