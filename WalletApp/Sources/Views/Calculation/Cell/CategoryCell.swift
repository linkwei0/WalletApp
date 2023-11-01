//
//  CategoryCell.swift
//  WalletApp
//

import UIKit

class CategoryCell: UICollectionViewCell {
  // MARK: - Properties
  private let containerView = UIView()
  private let categoryImageView = UIImageView()
  private let titleLabel = Label(textStyle: .footnoteBold)
  
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
    containerView.layer.cornerRadius = 16
    containerView.layer.borderWidth = 1.0
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
      make.edges.equalToSuperview().inset(12)
    }
  }
  
  private func setupTitleLabel() {
    containerView.addSubview(titleLabel)
    titleLabel.textColor = .baseBlack
    titleLabel.textAlignment = .center
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(categoryImageView.snp.bottom).offset(-4)
      make.leading.trailing.equalToSuperview().inset(10)
    }
  }
}
