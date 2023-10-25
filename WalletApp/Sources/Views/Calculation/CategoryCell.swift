//
//  CategoryCell.swift
//  WalletApp
//

import UIKit

class CategoryCell: UICollectionViewCell {
  // MARK: - Properties
  private let containerView = UIView()
  private let categoryImageView = UIImageView()
  
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
  func configure(with viewModel: CategoryCellViewModel) {
    categoryImageView.image = viewModel.iconImage
  }
  
  // MARK: - Setup
  private func setup() {
    setupContainerView()
    setupCategoryImageView()
  }
  
  private func setupContainerView() {
    contentView.addSubview(containerView)
    containerView.layer.cornerRadius = 16
    containerView.layer.borderWidth = 2.0
    containerView.backgroundColor = .accentDark
    containerView.layer.borderColor = UIColor.baseWhite.cgColor
    containerView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  private func setupCategoryImageView() {
    containerView.addSubview(categoryImageView)
    categoryImageView.clipsToBounds = true
    categoryImageView.tintColor = .baseWhite
    categoryImageView.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(10)
    }
  }
}
