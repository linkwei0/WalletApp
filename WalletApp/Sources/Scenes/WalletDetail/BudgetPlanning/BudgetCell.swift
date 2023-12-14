//
//  BudgetCell.swift
//  WalletApp
//
//  Created by Артём Бацанов on 21.11.2023.
//

import UIKit
import SnapKit

class BudgetCell: UITableViewCell, TableCell {
  // MARK: - Properties
  private let containerView = UIView()
  private let stackView = UIStackView()
  private let periodTypeLabel = Label(textStyle: .header2)
  private let containerProgressView = UIView()
  private let progressView = UIView()
  private let bottomStackView = UIStackView()
  private let remainderAmountLabel = Label(textStyle: .bodyBold)
  private let categoryLabel = Label(textStyle: .body)
  private let currencyLabel = Label(textStyle: .bodyBold)
  private let deleteButton = UIButton(type: .system)
  
  private let defaultWidth: CGFloat = 0
  private let maxPercent: CGFloat = 100
  
  private var maxWidthConstraint: Constraint?
  private var currentWidthConstraint: Constraint?
  
  private var viewModel: BudgetCellViewModel? {
    didSet {
      setupBindables()
    }
  }
  
  // MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  // MARK: - Lifecycle
  override func prepareForReuse() {
    super.prepareForReuse()
    deleteButton.isHidden = true
    contentView.alpha = 1
  }
  
  // MARK: - Configure
  func configure(with viewModel: TableCellViewModel) {
    guard let viewModel = viewModel as? BudgetCellViewModel else { return }
    self.viewModel = viewModel
    
    periodTypeLabel.text = viewModel.period
    categoryLabel.text = viewModel.category
    remainderAmountLabel.text = viewModel.remainderBudget
    currencyLabel.text = viewModel.currencyTitle
    
    if let maxWidth = maxWidthConstraint?.layoutConstraints[0].constant {
      var newWidth = (viewModel.progress * maxPercent * maxWidth) / maxPercent
      if newWidth > maxWidth {
        newWidth = maxWidth
      }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
          if newWidth > 0 {
          UIView.animate(withDuration: 0.6) {
            self.currentWidthConstraint?.layoutConstraints[0].constant = newWidth
            self.layoutIfNeeded()
          }
        } else {
          self.currentWidthConstraint?.layoutConstraints[0].constant = self.defaultWidth
        }
      }
    }
  }
  
  // MARK: - Setup
  private func setup() {
    setupBackground()
    setupContainerView()
    setupStackView()
    setupPeriodTypeLabel()
    setupProgressView()
    setupBottomStackView()
    setupCategoryLabel()
    setupAmountLabel()
    setupCurrencyLabel()
    setupDeleteButton()
  }
  
  private func setupBackground() {
    selectionStyle = .none
    backgroundColor = .clear
    let longTap = UILongPressGestureRecognizer(target: self, action: #selector(didLongTap(_:)))
    longTap.minimumPressDuration = 1
    longTap.delaysTouchesBegan = true
    contentView.addGestureRecognizer(longTap)
  }
  
  private func setupContainerView() {
    contentView.addSubview(containerView)
    containerView.layer.cornerRadius = 24
    containerView.backgroundColor = .accent
    containerView.layer.borderColor = UIColor.baseBlack.cgColor
    containerView.layer.borderWidth = 0.5
    containerView.addShadow(offset: CGSize(width: 0, height: 4), radius: 24, color: .zeroBlack, opacity: 0.1)
    containerView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(16)
      make.leading.trailing.equalToSuperview().inset(24)
    }
  }
  
  private func setupStackView() {
    containerView.addSubview(stackView)
    stackView.axis = .vertical
    stackView.spacing = 10
    stackView.distribution = .fill
    stackView.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
  
  private func setupPeriodTypeLabel() {
    stackView.addArrangedSubview(periodTypeLabel)
    periodTypeLabel.textColor = .baseWhite
    periodTypeLabel.textAlignment = .left
  }
  
  private func setupProgressView() {
    stackView.addArrangedSubview(containerProgressView)
    containerProgressView.backgroundColor = .shade2
    containerProgressView.layer.cornerRadius = 10
    containerProgressView.snp.makeConstraints { make in
      make.height.equalTo(20)
      maxWidthConstraint = make.width.equalTo(275).constraint
    }
    containerProgressView.addSubview(progressView)
    progressView.backgroundColor = .baseWhite
    progressView.layer.cornerRadius = 10
    progressView.snp.makeConstraints { make in
      make.top.bottom.leading.equalToSuperview()
      currentWidthConstraint = make.width.equalTo(defaultWidth).constraint
    }
  }
  
  private func setupBottomStackView() {
    stackView.addArrangedSubview(bottomStackView)
    bottomStackView.axis = .horizontal
    bottomStackView.spacing = 4
    bottomStackView.snp.makeConstraints { make in
      make.bottom.leading.trailing.equalToSuperview()
    }
  }
  
  private func setupCategoryLabel() {
    bottomStackView.addArrangedSubview(categoryLabel)
    categoryLabel.textColor = .baseWhite
    categoryLabel.textAlignment = .left
    
    let spacer = UIView()
    spacer.backgroundColor = .clear
    bottomStackView.addArrangedSubview(spacer)
  }
  
  private func setupAmountLabel() {
    bottomStackView.addArrangedSubview(remainderAmountLabel)
    remainderAmountLabel.textColor = .baseWhite
    remainderAmountLabel.textAlignment = .right
    remainderAmountLabel.snp.makeConstraints { make in
      make.width.equalTo(150)
    }
  }
  
  private func setupCurrencyLabel() {
    bottomStackView.addArrangedSubview(currencyLabel)
    currencyLabel.textColor = .baseWhite
    currencyLabel.textAlignment = .left
    currencyLabel.snp.makeConstraints { make in
      make.top.bottom.trailing.equalToSuperview()
    }
  }
  
  private func setupDeleteButton() {
    containerView.addSubview(deleteButton)
    deleteButton.isHidden = true
    deleteButton.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
    deleteButton.setImage(UIImage(systemName: Constants.deleteButtonImage)?.withRenderingMode(.alwaysTemplate), for: .normal)
    deleteButton.tintColor = .accentRed
    deleteButton.contentHorizontalAlignment = .fill
    deleteButton.contentVerticalAlignment = .fill
    deleteButton.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(-12)
      make.trailing.equalToSuperview().inset(-12)
      make.size.equalTo(30)
    }
  }
  
  // MARK: - Actions
  @objc private func didLongTap(_ sender: UILongPressGestureRecognizer) {
    if sender.state == .ended {
      viewModel?.deletionMode(isActive: true)
      showAnimation()
      deleteButton.isHidden = false
    }
  }
  
  @objc private func didTapDeleteButton() {
    deletionAnimation()
  }
  
  // MARK: - Private methods
  private func showAnimation() {
    guard contentView.layer.animation(forKey: Constants.wiggleNameAnimation) == nil else { return }
    guard contentView.layer.animation(forKey: Constants.bounceNameAnimation) == nil else { return }
    
    let angle = 0.04
    let wiggle = CAKeyframeAnimation(keyPath: Constants.wiggleTransformKeyFrame)
    wiggle.values = [-angle, angle]
    wiggle.autoreverses = true
    wiggle.duration = TimeInterval(0.15).randomInterval(variance: 0.025)
    wiggle.repeatCount = Float.infinity
    contentView.layer.add(wiggle, forKey: Constants.wiggleNameAnimation)
    
    let bounce = CAKeyframeAnimation(keyPath: Constants.bounceTransformKeyFrame)
    bounce.values = [4.0, 0.0]
    bounce.autoreverses = true
    bounce.duration = TimeInterval(0.12).randomInterval(variance: 0.025)
    bounce.repeatCount = Float.infinity
    contentView.layer.add(bounce, forKey: Constants.bounceNameAnimation)
  }
  
  private func deletionAnimation() {
    contentView.layer.removeAllAnimations()
    
    let animation = CABasicAnimation(keyPath: Constants.deletionPositionXAnimation)
    animation.toValue = -200
    animation.duration = 1
    self.contentView.layer.add(animation, forKey: Constants.deletionNameAnimation)

    UIView.animate(withDuration: 0.7) {
      self.contentView.alpha = 0
      self.deleteButton.isHidden = true
    } completion: { _ in
      self.viewModel?.didTapDeleteButton()
    }
  }
  
  // MARK: - Bindables
  private func setupBindables() {
    viewModel?.onNeedsToUpdateDeletionMode = { [weak self] in
      self?.deleteButton.isHidden = true
      self?.contentView.layer.removeAllAnimations()
    }
  }
}

// MARK: - Constants
private extension Constants {
  static let deleteButtonImage = "xmark.circle.fill"
  
  static let wiggleNameAnimation = "wiggle"
  static let wiggleTransformKeyFrame = "transform.rotation.z"
  
  static let bounceNameAnimation = "bounce"
  static let bounceTransformKeyFrame = "transform.translation.y"

  static let deletionPositionXAnimation = "position.x"
  static let deletionNameAnimation = "moveLeft"
}
