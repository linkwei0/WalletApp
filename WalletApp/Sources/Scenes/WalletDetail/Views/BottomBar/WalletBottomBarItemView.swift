//
//  BankBottomBarItemView.swift
//  WalletApp
//

import UIKit

class WalletBottomBarItemView: UIView {
  // MARK: - Properties
  
  var onDidTap: ((_ itemType: WalletBottomBarItemType) -> Void)?
  
  override var intrinsicContentSize: CGSize {
    CGSize(width: 56, height: 50)
  }
  
  private(set) var itemType: WalletBottomBarItemType?
  
  private let iconImageView = UIImageView()
  private let overlayButton = HighlightableButton()
  
  // MARK: - Init
  
  init() {
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Configure
  
  func configure(with itemType: WalletBottomBarItemType) {
    self.itemType = itemType
    
    iconImageView.image = itemType.icon?.withRenderingMode(.alwaysTemplate)
    iconImageView.tintColor = itemType.color
  }
  
  // MARK: - Actions
  
  @objc private func handleTap() {
    guard let itemType = itemType else { return }
    onDidTap?(itemType)
  }
  
  // MARK: - Setup
  
  private func setup() {
    setupIconImageView()
    setupOverlayButton()
  }
  
  private func setupIconImageView() {
    addSubview(iconImageView)
    iconImageView.contentMode = .scaleAspectFit
    iconImageView.snp.makeConstraints { make in
      make.size.equalTo(32)
      make.top.equalToSuperview()
      make.centerX.equalToSuperview()
    }
  }
    
  private func setupOverlayButton() {
    addSubview(overlayButton)
    overlayButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    overlayButton.onHighlightStateDidChange = { [weak self] isHighlighted in
      self?.setState(isHighlighted: isHighlighted)
    }
    overlayButton.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  // MARK: - Private methods
  
  private func setState(isHighlighted: Bool) {
    guard let itemType = itemType else { return }
    iconImageView.tintColor = isHighlighted ? itemType.highlightColor : itemType.color
  }
}
