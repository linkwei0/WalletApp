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
  
  private let defaultHeight: CGFloat = 350
  private let dismissibleHeight: CGFloat = 200
  private let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 325
  private let maxDimmedAlpha: CGFloat = 0.6
  private var currentContainerHeight: CGFloat = 350
  
  private let containerView = UIView()
  private let dimmedView = UIView()
  
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
  }
  
  private func setupDimmedView() {
    view.addSubview(dimmedView)
    dimmedView.backgroundColor = .black
    dimmedView.alpha = maxDimmedAlpha
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCloseAction))
    dimmedView.addGestureRecognizer(tapGesture)
    dimmedView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
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
  
  // MARK: - Actions
  @objc private func handleCloseAction() {
    animateDismissView()
  }
  
  @objc private func handlePanGesture(gesture: UIPanGestureRecognizer) {
    let translation = gesture.translation(in: view)
    let isDraggingDown = translation.y > 0
    let newHeight = currentContainerHeight - translation.y
    
    switch gesture.state {
    case .changed:
      if newHeight < maximumContainerHeight {
        containerViewHeightConstraint?.layoutConstraints[0].constant = newHeight
        view.layoutIfNeeded()
      }
    case .ended:
      if newHeight < dismissibleHeight {
        self.animateDismissView()
      } else if newHeight < defaultHeight {
        animateContainerHeight(defaultHeight)
      } else if newHeight < maximumContainerHeight && isDraggingDown {
        animateContainerHeight(defaultHeight)
      } else {
        animateContainerHeight(maximumContainerHeight)
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
