//
//  CalculationItemCell.swift
//  WalletApp
//

import UIKit

class CalculationItemCell: UICollectionViewCell {
  // MARK: - Properties
  
  var onDidTap: ((_ itemType: CalculationItemType) -> Void)?
  
  private(set) var itemType: CalculationItemType?
  
  private let iconImageView = UIImageView()
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Configure
  
  func configure(with itemType: CalculationItemType) {
    iconImageView.image = itemType.iconImage?.withRenderingMode(.alwaysTemplate)
  }
  
  // MARK: - Setup
  
  private func setup() {
    setupBackground()
    setupIconImage()
  }
  
  private func setupBackground() {
    layer.cornerRadius = 25
    layer.borderWidth = 2.5
    layer.borderColor = UIColor.baseWhite.cgColor
    backgroundColor = .accentDark
  }
  
  private func setupIconImage() {
    contentView.addSubview(iconImageView)
    iconImageView.tintColor = .baseWhite
    iconImageView.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(16)
    }
  }
}
