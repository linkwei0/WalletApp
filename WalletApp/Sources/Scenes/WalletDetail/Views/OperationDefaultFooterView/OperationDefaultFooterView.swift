//
//  OperationDefaultFooterView.swift
//  WalletApp
//
//  Created by Артём Бацанов on 08.11.2023.
//

import UIKit

class OperationDefaultFooterView: UITableViewHeaderFooterView, TableFooterView {
  // MARK: - Properties
  private let containerView = UIView()
  private let moreOperationsLabel = Label(textStyle: .body)
  private let arrowImageView = UIImageView()
  
  private var viewModel: OperationDefaultFooterViewModel?
  
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
    guard let viewModel = viewModel as? OperationDefaultFooterViewModel else { return }
    self.viewModel = viewModel
  }
  
  // MARK: - Setup
  private func setup() {
    setupContainerView()
    setupMoreOperationsLabel()
    setupArrowImageView()
  }
  
  private func setupContainerView() {
    contentView.addSubview(containerView)
    let tap = UITapGestureRecognizer(target: self, action: #selector(didTapMoreOperations))
    containerView.addGestureRecognizer(tap)
    containerView.snp.makeConstraints { make in
      make.trailing.bottom.equalToSuperview()
      make.height.equalTo(30)
      make.width.equalTo(160)
    }
  }
  
  private func setupMoreOperationsLabel() {
    containerView.addSubview(moreOperationsLabel)
    moreOperationsLabel.text = R.string.walletDetail.defaultFooterViewTitle()
    moreOperationsLabel.textColor = .accent
    moreOperationsLabel.textAlignment = .right
    moreOperationsLabel.snp.makeConstraints { make in
      make.top.bottom.leading.equalToSuperview().inset(2)
    }
  }
  
  private func setupArrowImageView() {
    containerView.addSubview(arrowImageView)
    arrowImageView.image = R.image.redArrow()?.withRenderingMode(.alwaysTemplate)
    arrowImageView.tintColor = .accent
    arrowImageView.contentMode = .scaleAspectFit
    arrowImageView.snp.makeConstraints { make in
      make.leading.equalTo(moreOperationsLabel.snp.trailing).offset(4)
      make.centerY.equalTo(moreOperationsLabel.snp.centerY).offset(2)
      make.size.equalTo(10)
    }
  }
  
  // MARK: - Actions
  @objc private func didTapMoreOperations() {
    viewModel?.didTapMoreOperations()
  }
}
