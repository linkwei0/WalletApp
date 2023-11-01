//
//  CommonButton.swift
//  WalletApp
//

import UIKit

class CommonButton: UIButton {
  // MARK: - Properties

  override var intrinsicContentSize: CGSize {
    return CGSize(width: super.intrinsicContentSize.width + 32, height: style.height)
  }

  override var isHighlighted: Bool {
    didSet {
      updateAppearance()
    }
  }

  override var isEnabled: Bool {
    didSet {
      updateAppearance()
    }
  }

  private let style: CommonButtonStyle

  // MARK: - Init

  init(style: CommonButtonStyle = .default) {
    self.style = style
    super.init(frame: .zero)
    setup()
  }

  required init?(coder: NSCoder) {
    self.style = .default
    super.init(coder: coder)
    setup()
  }

  // MARK: - Public methods

  func startAnimating() {
    titleLabel?.alpha = 0
    isUserInteractionEnabled = false
  }

  func stopAnimating() {
    titleLabel?.alpha = 1
    isUserInteractionEnabled = true
  }

  // MARK: - Setup

  private func setup() {
    setupButton()
  }

  private func setupButton() {
    backgroundColor = style.backgroudColor
    setTitleColor(style.textColor, for: .normal)
    layer.cornerRadius = 4
    titleLabel?.font = style.font
    titleLabel?.adjustsFontForContentSizeCategory = true
  }

  // MARK: - Private methods

  private func updateAppearance() {
    guard isEnabled else {
      backgroundColor = style.disabledBackgroundColor
      setTitleColor(style.disabledTextColor, for: .normal)
      return
    }

    backgroundColor = isHighlighted ? style.highlightedBackgroundColor : style.backgroudColor
    setTitleColor(isHighlighted ? style.highlightedTextColor : style.textColor, for: .normal)
  }
}
