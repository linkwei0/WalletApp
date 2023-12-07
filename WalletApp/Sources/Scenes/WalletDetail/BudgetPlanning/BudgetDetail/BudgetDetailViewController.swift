//
//  BudgetDetailViewController.swift
//  WalletApp
//
//  Created by Артём Бацанов on 23.11.2023.
//

import UIKit
import SnapKit

class BudgetDetailViewController: BaseViewController {
  // MARK: - Properties
  private var containerViewHeightConstraint: Constraint?
  private var containerViewBottomConstraint: Constraint?
  
  private let maxDimmedAlpha: CGFloat = 0.6
  private let defaultHeight: CGFloat = 320
  
  private let dimmedView = UIView()
  private let containerView = UIView()
  
  private let stackView = UIStackView()
  private let moreTitleLabel = Label(textStyle: .header1)
  private let nameLabel = Label(textStyle: .bodyBold)
  
  let viewModel: BudgetDetailViewModel
  
  // MARK: - Init
  init(viewModel: BudgetDetailViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    setupBindables()
    viewModel.viewIsReady()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    animateShowDimmedView()
    animateShowContainerView()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    containerView.applyGradient(startColor: .accentDark, endColor: .accentFaded)
  }
  
  // MARK: - Setup
  private func setup() {
    setupBackground()
    setupDimmedView()
    setupContainerView()
    setupStackView()
    setupTitleLabel()
  }
  
  private func setupStackView() {
    containerView.addSubview(stackView)
    stackView.axis = .vertical
    stackView.spacing = 12
    stackView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(10)
      make.leading.trailing.equalToSuperview().inset(64)
    }
  }
  
  private func setupTitleLabel() {
    stackView.addArrangedSubview(moreTitleLabel)
    moreTitleLabel.text = R.string.walletDetail.budgetDetailTitle()
    moreTitleLabel.textColor = .baseWhite
    moreTitleLabel.textAlignment = .center
  }
  
  private func setupBackground() {
    view.backgroundColor = .clear
  }
  
  private func setupDimmedView() {
    view.addSubview(dimmedView)
    dimmedView.backgroundColor = .baseBlack
    dimmedView.alpha = maxDimmedAlpha
    let tap = UITapGestureRecognizer(target: self, action: #selector(didTapDimmedView))
    dimmedView.addGestureRecognizer(tap)
    dimmedView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  private func setupContainerView() {
    view.addSubview(containerView)
    containerView.backgroundColor = .baseWhite
    containerView.layer.cornerRadius = 16
    containerView.clipsToBounds = true
    containerView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      containerViewHeightConstraint = make.height.equalTo(defaultHeight).constraint
      containerViewBottomConstraint = make.bottom.equalTo(view.snp.bottom).offset(defaultHeight).constraint
    }
  }
  
  // MARK: - Actions
  @objc private func didTapDimmedView() {
    animateDismissView()
  }
  
  // MARK: - Private methods
  private func animateShowDimmedView() {
    dimmedView.alpha = 0
    UIView.animate(withDuration: 0.4) {
      self.dimmedView.alpha = self.maxDimmedAlpha
    }
  }
  
  private func animateShowContainerView() {
    UIView.animate(withDuration: 0.3) {
      self.containerViewBottomConstraint?.layoutConstraints[0].constant = 0
      self.view.layoutIfNeeded()
    }
  }
  
  private func animateDismissView() {
    UIView.animate(withDuration: 0.3) {
      self.containerViewBottomConstraint?.layoutConstraints[0].constant = self.defaultHeight
      self.view.layoutIfNeeded()
    }
    dimmedView.alpha = maxDimmedAlpha
    UIView.animate(withDuration: 0.4) {
      self.dimmedView.alpha = 0
    } completion: { [weak self] _ in
      self?.viewModel.dismiss(animated: false)
    }
  }
    
  private func configureHStackView(text1: String?, text2: String?) {
    let hStackView = UIStackView()
    stackView.addArrangedSubview(hStackView)
    hStackView.axis = .horizontal
    hStackView.spacing = 12
    hStackView.distribution = .equalCentering
    
    let infoLabel1 = Label(textStyle: .bodyBold)
    infoLabel1.text = text1
    infoLabel1.textColor = .baseWhite
    let infoLabel2 = Label(textStyle: .body)
    infoLabel2.text = text2
    infoLabel2.textColor = .baseWhite
    
    [infoLabel1, infoLabel2].forEach { hStackView.addArrangedSubview($0) }
    hStackView.snp.makeConstraints { make in
      make.height.equalTo(20)
    }
    
    let separatorView = UIView()
    stackView.addArrangedSubview(separatorView)
    separatorView.backgroundColor = .shade2
    separatorView.snp.makeConstraints { make in
      make.height.equalTo(0.4)
    }
  }
  
  // MARK: - Bindables
  private func setupBindables() {
    viewModel.onNeedsUpdateView = { [weak self] in
      self?.configureHStackView(text1: R.string.walletDetail.budgetDetailRowName(), text2: self?.viewModel.name)
      self?.configureHStackView(text1: R.string.walletDetail.budgetDetailRowCategory(), text2: self?.viewModel.category)
      self?.configureHStackView(text1: R.string.walletDetail.budgetDetailRowPeriod(), text2: self?.viewModel.period)
      self?.configureHStackView(text1: R.string.walletDetail.budgetDetailRowSpent(), text2: self?.viewModel.spentAmount)
      self?.configureHStackView(text1: "", text2: self?.viewModel.spentAmountAtPercent)
    }
  }
}
