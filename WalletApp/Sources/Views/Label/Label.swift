//
//  Label.swift
//  WalletApp
//

import UIKit

class Label: UILabel {
  override var text: String? {
    didSet {
      updateText()
    }
  }
  
  private let textStyle: TextStyle
  
  init(textStyle: TextStyle) {
    self.textStyle = textStyle
    super.init(frame: .zero)
    setup()
  }
  
  override func drawText(in rect: CGRect) {
    guard let font = super.font else {
      return super.drawText(in: rect)
    }
    
    var newRect = rect
    let offset = 0.5 * (textStyle.lineHeight - font.lineHeight)
    newRect.origin = CGPoint(x: rect.origin.x, y: -offset)
    super.drawText(in: newRect)
  }
  
  required init?(coder: NSCoder) {
    self.textStyle = .body
    super.init(coder: coder)
    setup()
  }
  
  private func setup() {
    font = textStyle.font
    textColor = .baseBlack
    adjustsFontForContentSizeCategory = true
  }
  
  private func updateText() {
    guard let text = text else { return }
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = textStyle.lineHeight / font.lineHeight
    paragraphStyle.alignment = textAlignment
    
    let attributes: [NSAttributedString.Key: Any] = [
      .paragraphStyle: paragraphStyle,
      .font: font ?? UIFont.systemFont(ofSize: 16)
    ]
    
    let attributedString = NSAttributedString(string: text, attributes: attributes)
    self.attributedText = attributedString
  }
}
