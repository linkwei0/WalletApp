//
//  HistoryCell.swift
//  WalletApp
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

typealias OperationItemCell = TableCellContainer<OperationItemView>

class OperationItemView: UIView, Configurable {
  // MARK: - Properties
  private let titleLabel = Label(textStyle: .body)
  private let categoryImageView = UIImageView()
  private let amountLabel = Label(textStyle: .footnoteBold)
  private let stackView = UIStackView()
  
  // MARK: - Init
  init() {
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  // MARK: - Configure
  func configure(with viewModel: OperationCellViewModel) {
    titleLabel.text = viewModel.name
    amountLabel.text = (viewModel.isIncome ? "+" : "-") + viewModel.amount.maxLength(to: 7)
    amountLabel.textColor = viewModel.isIncome ? .incomeBtnColor : .expenseBtnColor
    categoryImageView.image = viewModel.category.image
  }
  
  // MARK: - Setup
  private func setup() {
    setupStackView()
    setupTitleLabel()
    setupCategoryImageView()
    setupAmountLabel()
  }
  
  private func setupTitleLabel() {
    titleLabel.textAlignment = .left
    titleLabel.numberOfLines = 0
  }
  
  private func setupCategoryImageView() {
    categoryImageView.contentMode = .scaleAspectFit
    categoryImageView.tintColor = .shade2
    categoryImageView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
    }
  }
  
  private func setupAmountLabel() {
    amountLabel.textAlignment = .right
    amountLabel.numberOfLines = 0
  }
  
  private func setupStackView() {
    addSubview(stackView)
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.spacing = 16
    
    [titleLabel, categoryImageView, amountLabel].forEach { stackView.addArrangedSubview($0) }
    
    stackView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(4)
      make.leading.trailing.equalToSuperview().inset(16)
    }
  }
}
