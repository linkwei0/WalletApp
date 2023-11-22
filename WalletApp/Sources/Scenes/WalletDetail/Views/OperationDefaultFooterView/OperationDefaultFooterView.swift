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
  private let moreOperationsLabel = Label(textStyle: .footnote)
  private let arrowImageView = UIImageView()
  private let stackView = UIStackView()
  
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
  
  override func layoutSubviews() {
    super.layoutSubviews()
    containerView.applyGradient(startColor: .accentDark, endColor: .accentFaded)
  }
  
  // MARK: - Configure
  func configure(with viewModel: TableFooterViewModel) {
    guard let viewModel = viewModel as? OperationDefaultFooterViewModel else { return }
    self.viewModel = viewModel
  }
  
  // MARK: - Setup
  private func setup() {
    setupContainerView()
    setupStackView()
    setupMoreOperationsLabel()
    setupArrowImageView()
  }
  
  private func setupContainerView() {
    contentView.addSubview(containerView)
    let tap = UITapGestureRecognizer(target: self, action: #selector(didTapMoreOperations))
    containerView.addGestureRecognizer(tap)
    containerView.snp.makeConstraints { make in
      make.trailing.equalToSuperview().inset(12)
      make.bottom.equalToSuperview().inset(8)
      make.height.equalTo(30)
      make.width.equalTo(80)
    }
  }
  
  private func setupMoreOperationsLabel() {
    moreOperationsLabel.text = R.string.walletDetail.defaultFooterViewTitle()
    moreOperationsLabel.textColor = .baseWhite
    moreOperationsLabel.textAlignment = .center
  }
  
  private func setupArrowImageView() {
    arrowImageView.image = R.image.redArrow()?.withRenderingMode(.alwaysTemplate)
    arrowImageView.tintColor = .baseWhite
    arrowImageView.contentMode = .scaleAspectFit
  }
  
  private func setupStackView() {
    containerView.addSubview(stackView)
    stackView.axis = .horizontal
    stackView.spacing = 2
    stackView.distribution = .equalCentering
    [moreOperationsLabel, arrowImageView].forEach { stackView.addArrangedSubview($0) }
    stackView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(8)
      make.leading.trailing.equalToSuperview().inset(10)
    }
  }
  
  // MARK: - Actions
  @objc private func didTapMoreOperations() {
    viewModel?.didTapMoreOperations()
  }
}
