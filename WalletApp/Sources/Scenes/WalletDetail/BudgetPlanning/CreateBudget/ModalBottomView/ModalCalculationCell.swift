//
//  ButtonCollectionCell.swift
//  WalletApp
//
//  Created by Артём Бацанов on 16.11.2023.
//

import UIKit

class ModalCalculationCell: UICollectionViewCell {
  // MARK: - Properties
  private let containerView = UIView()
  private let elementImageView = UIImageView()
  
  private var viewModel: ElementCollectionCellViewModel?
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  // MARK: - Configure
  func configure(with viewModel: ElementCollectionCellViewModel) {
    self.viewModel = viewModel
    elementImageView.image = viewModel.iconImage
  }
  
  // MARK: - Setup
  private func setup() {
    setupTapGestureRecognizer()
    setupContainerView()
    setupElementImageView()
  }
  
  private func setupTapGestureRecognizer() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(didTapOnElement))
    contentView.addGestureRecognizer(tap)
  }
  
  private func setupContainerView() {
    contentView.addSubview(containerView)
    containerView.layer.borderWidth = 0.4
    containerView.layer.borderColor = UIColor.baseBlack.cgColor
    containerView.layer.cornerRadius = 12
    containerView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  private func setupElementImageView() {
    containerView.addSubview(elementImageView)
    elementImageView.tintColor = .baseBlack
    elementImageView.contentMode = .scaleAspectFit
    elementImageView.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(16)
    }
  }
  
  // MARK: - Actions
  @objc private func didTapOnElement() {
    viewModel?.select()
  }
}
