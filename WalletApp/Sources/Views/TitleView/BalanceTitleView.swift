//
//  BalanceTitleView.swift
//  WalletApp
//

import UIKit

class BalanceTitleView: UIView {
  // MARK: - Properties
  var amount: String? {
    get {
      amountLabel.text
    }
    set {
      amountLabel.text = newValue
    }
  }

  var currencyImage: UIImage? {
    get {
      currencyImageView.image
    }
    set {
      currencyImageView.image = newValue
    }
  }
  
  private let stackView = UIStackView()
  private let amountLabel = Label(textStyle: .body)
  private let currencyImageView = UIImageView()
  
  // MARK: - Init
  
  init() {
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  // MARK: - Setup
  
  private func setup() {
    setupStackView()
    setupAmountLabel()
    setupCurrencyImageView()
  }
  
  private func setupStackView() {
    addSubview(stackView)
    stackView.axis = .vertical
    stackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  private func setupAmountLabel() {
    stackView.addArrangedSubview(amountLabel)
    amountLabel.font = .appBold
    amountLabel.textColor = .baseWhite
    amountLabel.textAlignment = .center
  }
  
  private func setupCurrencyImageView() {
    stackView.addArrangedSubview(currencyImageView)
    currencyImageView.tintColor = .baseWhite
  }
}
