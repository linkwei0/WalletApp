//
//  EmptyStateView.swift
//  WalletApp
//
//  Created by Артём Бацанов on 30.10.2023.
//

import UIKit

class EmptyStateView: UIView {
  // MARK: - Properties
  
  private let stackView = UIStackView()
  private let imageView = UIImageView()
  private let titleLabel = Label(textStyle: .bodyBold)
  private let subtitleLabel = Label(textStyle: .body)
  private let additionalTextLabel = UILabel()
  
  // MARK: - Init
  
  init() {
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  // MARK: - Configure
  
  func configure(with viewModel: EmptyStateViewModel) {
    imageView.image = viewModel.image
    imageView.isHidden = viewModel.shouldHideImage
    if let imageSize = viewModel.imageSize {
      imageView.snp.makeConstraints { make in
        make.size.equalTo(imageSize)
      }
    }
    
    titleLabel.text = viewModel.title
    titleLabel.isHidden = viewModel.shouldHideTitle
    
    subtitleLabel.text = viewModel.subtitle
    subtitleLabel.isHidden = viewModel.shouldHideSubtitle
    
    additionalTextLabel.text = viewModel.additionalText
    additionalTextLabel.font = viewModel.additionalTextFont
    additionalTextLabel.isHidden = viewModel.shouldHideAdditionalText
  }
  
  // MARK: - Setup
  
  private func setup() {
    setupStackView()
    setupImageView()
    setupTitleLabel()
    setupSubtitleLabel()
    setupAdditionalTextLabel()
  }
  
  private func setupStackView() {
    addSubview(stackView)
    stackView.axis = .vertical
    stackView.spacing = 4
    stackView.alignment = .center
    stackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  private func setupImageView() {
    stackView.addArrangedSubview(imageView)
    imageView.contentMode = .scaleAspectFit
    imageView.tintColor = .accentYellow
    stackView.setCustomSpacing(16, after: imageView)
  }
  
  private func setupTitleLabel() {
    stackView.addArrangedSubview(titleLabel)
    titleLabel.textColor = .baseBlack
    titleLabel.numberOfLines = 0
    titleLabel.textAlignment = .center
  }
  
  private func setupSubtitleLabel() {
    stackView.addArrangedSubview(subtitleLabel)
    subtitleLabel.textColor = .baseBlack
    subtitleLabel.numberOfLines = 0
    subtitleLabel.textAlignment = .center
  }
  
  private func setupAdditionalTextLabel() {
    stackView.addArrangedSubview(additionalTextLabel)
    additionalTextLabel.textColor = .baseBlack
    additionalTextLabel.numberOfLines = 0
    additionalTextLabel.textAlignment = .center
  }
}
