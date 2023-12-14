//
//  CategoryCell.swift
//  WalletApp
//

import UIKit

class CategoryCell: UICollectionViewCell {
  // MARK: - Properties
  private let containerView = UIView()
  private let categoryImageView = UIImageView()
  private let titleLabel = Label(textStyle: .body)
  
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
    titleLabel.text = viewModel.title
    categoryImageView.tintColor = viewModel.imageColor
  }
  
  // MARK: - Setup
  private func setup() {
    setupContainerView()
    setupCategoryImageView()
    setupTitleLabel()
  }
  
  private func setupContainerView() {
    contentView.addSubview(containerView)
    containerView.layer.cornerRadius = 12
    containerView.layer.borderWidth = 0.7
    containerView.backgroundColor = .accent
    containerView.layer.borderColor = UIColor.baseBlack.cgColor
    containerView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  private func setupCategoryImageView() {
    containerView.addSubview(categoryImageView)
    categoryImageView.clipsToBounds = true
    categoryImageView.contentMode = .scaleAspectFit
    categoryImageView.tintColor = .baseWhite
    categoryImageView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(12)
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(55)
    }
  }
  
  private func setupTitleLabel() {
    containerView.addSubview(titleLabel)
    titleLabel.textColor = .baseWhite
    titleLabel.textAlignment = .center
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(categoryImageView.snp.bottom).offset(12)
      make.leading.trailing.equalToSuperview().inset(10)
    }
  }
}
