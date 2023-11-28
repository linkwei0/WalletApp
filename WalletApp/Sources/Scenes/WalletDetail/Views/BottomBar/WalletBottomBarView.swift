//
//  BankBottomBarView.swift
//  WalletApp
//

import UIKit

class WalletBottomBarView: UIView {
  // MARK: - Properties
  
  var onDidSelectItem: ((_ itemType: WalletBottomBarItemType) -> Void)?
  
  private let stackView = UIStackView()
  
  private let bottomBarItems: [WalletBottomBarItemType]
  
  // MARK: - Init
  
  init(configuration: WalletBottomBarConfiguration) {
    self.bottomBarItems = configuration.bottomBarItems
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    applyGradient(startColor: .accentDark, endColor: .accentFaded)
  }

  // MARK: - Public methods

  func update(itemOfType type: WalletBottomBarItemType, withType newType: WalletBottomBarItemType) {
    stackView.arrangedSubviews.compactMap { $0 as? WalletBottomBarItemView }
    .first { $0.itemType == type }?.configure(with: newType)
  }
  
  // MARK: - Setup
  
  private func setup() {
    setupContainer()
    setupBackgroundView()
    setupStackView()
    setupBottomBarItems()
  }
  
  private func setupContainer() {
    layer.cornerRadius = 12
    addShadow(offset: CGSize(width: 0, height: 6), radius: 24, color: .baseBlack, opacity: 0.08)
  }
  
  private func setupBackgroundView() {
    layer.borderWidth = 2.0
    layer.borderColor = UIColor.accentDark.cgColor
    backgroundColor = .accent
  }
  
  private func setupStackView() {
    addSubview(stackView)
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    stackView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(16)
      make.top.bottom.equalToSuperview().inset(8)
    }
  }
  
  private func setupBottomBarItems() {
    bottomBarItems.forEach { item in
      let itemView = WalletBottomBarItemView()
      itemView.configure(with: item)
      itemView.onDidTap = { [weak self] itemType in
        self?.onDidSelectItem?(itemType)
      }
      stackView.addArrangedSubview(itemView)
    }
  }
}
