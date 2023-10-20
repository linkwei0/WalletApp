//
//  BankBottomBarView.swift
//  WalletApp
//

import UIKit

class BankBottomBarView: UIView {
  // MARK: - Properties
  
  var onDidSelectItem: ((_ itemType: BankBottomBarItemType) -> Void)?
  
  override var intrinsicContentSize: CGSize {
    CGSize(width: UIView.noIntrinsicMetric, height: 56)
  }
  
  private let stackView = UIStackView()
  
  private let bottomBarItems: [BankBottomBarItemType]
  
  // MARK: - Init
  
  init(configuration: BankBottomBarConfiguration) {
    self.bottomBarItems = configuration.bottomBarItems
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Public methods

  func update(itemOfType type: BankBottomBarItemType, withType newType: BankBottomBarItemType) {
    stackView.arrangedSubviews.compactMap { $0 as? BankBottomBarItemView }
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
      let itemView = BankBottomBarItemView()
      itemView.configure(with: item)
      itemView.onDidTap = { [weak self] itemType in
        self?.onDidSelectItem?(itemType)
      }
      stackView.addArrangedSubview(itemView)
    }
  }
}
