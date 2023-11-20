//
//  CalculationModalViewController.swift
//  WalletApp
//
//  Created by Артём Бацанов on 16.11.2023.
//

import UIKit
import SnapKit

class CalculationModalViewController: BaseViewController {
  // MARK: - Properties
  private var containerViewHeightConstraint: Constraint?
  private var containerViewBottomConstraint: Constraint?
  
  private let defaultHeight: CGFloat = 300
  private let dismissibleHeight: CGFloat = 200
  private let maxDimmedAlpha: CGFloat = 0.35
  private var currentContainerHeight: CGFloat = 300
  
  private let containerView = UIView()
  private let dimmedView = UIView()
  private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  
  private let viewModel: CalculationModalViewModel
  
  // MARK: - Init
  init(viewModel: CalculationModalViewModel) {
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
    setupPanGesture()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    animateShowDimmedView()
    animatePresentContainer()
  }
  
  // MARK: - Setup
  func setup() {
    view.backgroundColor = .clear
    setupDimmedView()
    setupContainerView()
    setupCollectionView()
  }
  
  private func setupDimmedView() {
    view.addSubview(dimmedView)
    dimmedView.backgroundColor = .black
    dimmedView.alpha = maxDimmedAlpha
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCloseAction))
    dimmedView.addGestureRecognizer(tapGesture)
    dimmedView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(150)
      make.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  private func setupContainerView() {
    view.addSubview(containerView)
    containerView.backgroundColor = .white
    containerView.layer.cornerRadius = 16
    containerView.clipsToBounds = true
    containerView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      containerViewHeightConstraint = make.height.equalTo(defaultHeight).constraint
      containerViewBottomConstraint = make.bottom.equalTo(view.snp.bottom).offset(defaultHeight).constraint
    }
  }
  
  private func setupCollectionView() {
    containerView.addSubview(collectionView)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(ModalCalculationCell.self, forCellWithReuseIdentifier: ModalCalculationCell.reuseIdentifiable)
    collectionView.snp.makeConstraints { make in
//      make.edges.equalToSuperview()
      make.top.equalToSuperview().inset(24)
      make.leading.trailing.equalToSuperview().inset(16)
      make.bottom.equalToSuperview()
    }
  }
  
  // MARK: - Actions
  @objc private func handleCloseAction() {
    animateDismissView()
  }
  
  @objc private func handlePanGesture(gesture: UIPanGestureRecognizer) {
    let translation = gesture.translation(in: view)
    let newHeight = currentContainerHeight - translation.y
    
    switch gesture.state {
    case .changed:
      if newHeight < defaultHeight {
        containerViewHeightConstraint?.layoutConstraints[0].constant = newHeight
        view.layoutIfNeeded()
      }
    case .ended:
      if newHeight < dismissibleHeight {
        self.animateDismissView()
      } else if newHeight < defaultHeight {
        animateContainerHeight(defaultHeight)
      }
    default:
      break
    }
  }

  // MARK: - Private methods
  private func animateShowDimmedView() {
    dimmedView.alpha = 0
    UIView.animate(withDuration: 0.4) {
      self.dimmedView.alpha = self.maxDimmedAlpha
    }
  }
  
  private func animatePresentContainer() {
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
    } completion: { _ in
      self.dismiss(animated: false)
    }
  }
  
  private func setupPanGesture() {
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))
    panGesture.delaysTouchesBegan = false
    panGesture.delaysTouchesEnded = false
    view.addGestureRecognizer(panGesture)
  }
  
  private func animateContainerHeight(_ height: CGFloat) {
    UIView.animate(withDuration: 0.4) {
      self.containerViewHeightConstraint?.layoutConstraints[0].constant = height
      self.view.layoutIfNeeded()
    }
    currentContainerHeight = height
  }
}

// MARK: - UICollectionViewDataSource
extension CalculationModalViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return viewModel.numberOfSections()
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.numberOfRowsInSection(section: section)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ModalCalculationCell.reuseIdentifiable,
                                        for: indexPath) as? ModalCalculationCell else { return UICollectionViewCell() }
    cell.configure(with: viewModel.configureCellViewModel(at: indexPath))
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CalculationModalViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (view.frame.width - 60) / 3
    return CGSize(width: width, height: width / 2)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 3, left: 2, bottom: 3, right: 2)
  }
}
