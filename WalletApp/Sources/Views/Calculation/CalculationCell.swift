//
//  CalculationItemCell.swift
//  WalletApp
//

import UIKit

class CalculationCell: UICollectionViewCell {
  // MARK: - Properties
    
  private(set) var itemType: CalculationItemType?
  private let iconImageView = UIImageView()
  
  private var viewModel: CalculationCellViewModel?
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCell))
    addGestureRecognizer(tap)
  }
  
  @objc private func didTapCell() {
    viewModel?.didTapCell()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Configure
  
  func configure(with viewModel: CalculationCellViewModel) {
    self.viewModel = viewModel
    
    iconImageView.tintColor = viewModel.tintColor
    iconImageView.image = viewModel.iconImage?.withRenderingMode(.alwaysTemplate)
  }
  
  // MARK: - Setup
  
  private func setup() {
    setupBackground()
    setupIconImage()
  }
  
  private func setupBackground() {
    layer.cornerRadius = 25
    backgroundColor = UIColor.blueLight
  }
  
  private func setupIconImage() {
    contentView.addSubview(iconImageView)
    iconImageView.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(12)
    }
  }
}
