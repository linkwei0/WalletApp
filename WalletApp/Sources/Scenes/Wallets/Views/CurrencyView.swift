//
//  CurrenciesView.swift
//  WalletApp
//

import UIKit

class CurrencyView: UIView {
  // MARK: - Properties
  private let stackView = UIStackView()
  
  private let viewModel: CurrencyViewModel
  
  // MARK: - Init
  init(viewModel: CurrencyViewModel) {
    self.viewModel = viewModel
    super.init(frame: .zero)
    setup()
    setupBindables()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Configure
  private func configure(with currencies: [CurrencyModelView]) {
    stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    currencies.forEach { stackView.addArrangedSubview(configureCurrencyStackView(with: $0)) }
  }
  
  // MARK: - Private methods
  private func setup() {
    setupBackground()
    setupStackView()
  }
  
  private func setupBackground() {
    backgroundColor = .systemGray5
    layer.cornerRadius = 16
  }
  
  private func setupStackView() {
    addSubview(stackView)
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    stackView.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(25)
    }
  }
  
  private func configureCurrencyStackView(with currency: CurrencyModelView) -> UIStackView {
    let imageView = UIImageView(image: CurrencyModelView.WalletsCurrencyType(rawValue: currency.code)?.iconImage)
    imageView.tintColor = .baseWhite
    imageView.snp.makeConstraints { make in
      make.size.equalTo(25)
    }
    
    let valueLabel = Label(textStyle: .footnoteBold)
    valueLabel.text = "\(currency.value)"
    
    let arrow = UIImageView(image: currency.isIncrease ? R.image.greenArrow() : R.image.redArrow())
    
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.spacing = 5
    
    [imageView, valueLabel, arrow].forEach { stackView.addArrangedSubview($0) }
    
    return stackView
  }
  
  // MARK: - Bindables
  private func setupBindables() {
    viewModel.currencies.bind { [weak self] currency in
      self?.configure(with: currency)
    }
  }
}
