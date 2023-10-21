//
//  CurrenciesView.swift
//  WalletApp
//
//  Created by Артём Бацанов on 11.10.2023.
//

import UIKit

class CurrenciesView: UIView {
  // MARK: - Properties
  private let stackView = UIStackView()
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  // MARK: - Public methods
  func configure(with currencies: [CurrencyModel]) {
    stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    currencies.forEach { stackView.addArrangedSubview(configureCurrencyStackView(with: $0)) }
  }
  
  // MARK: - Private methods
  private func setup() {
    setupBackground()
    setupStackView()
  }
  
  private func setupBackground() {
    backgroundColor = .systemGray6
    layer.cornerRadius = 12
  }
  
  private func setupStackView() {
    addSubview(stackView)
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .equalSpacing
    stackView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(8)
      make.leading.trailing.equalToSuperview().inset(16)
      make.bottom.equalToSuperview().inset(8)
    }
  }
  
  private func configureCurrencyStackView(with currency: CurrencyModel) -> UIStackView {
    let titleLabel = Label(textStyle: .body)
    titleLabel.text = currency.code
    titleLabel.textColor = .baseWhite
    
    let valueLabel = Label(textStyle: .bodyBold)
    valueLabel.text = "\(currency.value)"
    
    let arrow = UIImageView(image: currency.isIncrease ? R.image.greenArrow() : R.image.redArrow())
    
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.spacing = 5
    
    [titleLabel, valueLabel, arrow].forEach { stackView.addArrangedSubview($0) }
    
    return stackView
  }
}
