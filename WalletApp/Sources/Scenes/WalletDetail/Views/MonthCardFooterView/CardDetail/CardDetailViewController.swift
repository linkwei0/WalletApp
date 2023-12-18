//
//  CardDetailViewController.swift
//  WalletApp
//
//  Created by Артём Бацанов on 15.12.2023.
//

import UIKit
import SnapKit

class CardDetailViewController: BaseViewController, NavigationBarHiding {
  // MARK: - Properties
  private var containerViewHeightConstraint: Constraint?
  private var conatinerViewBottomConstraint: Constraint?
  
  private var currentContainerHeight: CGFloat = 450
  
  private let maxHeight: CGFloat = 650
  private let maxDimmedAlpha: CGFloat = 0.6
  private let defaultHeight: CGFloat = 450
  private let dismissableHeight: CGFloat = 300
  
  private let dimmedView = UIView()
  private let containerView = UIView()
  private let lineView = UIView()
  private let tableView = UITableView(frame: .zero, style: .grouped)
  
  private let dataSource = TableViewDataSource()
  
  private let viewModel: CardDetailViewModel
  
  // MARK: - Init
  init(viewModel: CardDetailViewModel) {
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
    setupBindables()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    animateShowDimmedView()
    animateShowContainerView()
  }
  
  // MARK: - Setup
  private func setup() {
    setupBackground()
    setupDimmedView()
    setupContainerView()
    setupLineView()
    setupTableView()
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
    containerView.layer.cornerRadius = 12
    containerView.clipsToBounds = true
    containerView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      containerViewHeightConstraint = make.height.equalTo(defaultHeight).constraint
      conatinerViewBottomConstraint = make.bottom.equalTo(view.snp.bottom).offset(defaultHeight).constraint
    }
  }
  
  private func setupLineView() {
    containerView.addSubview(lineView)
    lineView.backgroundColor = .shade2
    lineView.layer.cornerRadius = 3
    lineView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(4)
      make.leading.trailing.equalToSuperview().inset(150)
      make.height.equalTo(6)
    }
  }
  
  private func setupTableView() {
    containerView.addSubview(tableView)
    tableView.rowHeight = 44
    tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    tableView.separatorColor = .shade2
    tableView.showsVerticalScrollIndicator = true
    tableView.backgroundColor = .clear
    tableView.register(OperationItemCell.self, forCellReuseIdentifier: OperationItemCell.reuseIdentifiable)
    tableView.register(OperationDateHeaderView.self, 
                       forHeaderFooterViewReuseIdentifier: OperationDateHeaderView.reuseIdentifiable)
    tableView.register(OperationHeaderView.self, forHeaderFooterViewReuseIdentifier: OperationHeaderView.reuseIdentifiable)
    tableView.snp.makeConstraints { make in
      make.top.equalTo(lineView.snp.bottom).offset(16)
      make.leading.trailing.bottom.equalToSuperview()
    }
    dataSource.setup(tableView: tableView, viewModel: viewModel)
    dataSource.delegate = self
  }
  
  private func setupPanGesture() {
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))
    panGesture.delaysTouchesBegan = false
    panGesture.delaysTouchesEnded = false
    view.addGestureRecognizer(panGesture)
  }
  
  // MARK: - Actions
  @objc private func didTapDimmedView() {
    animateDismissView()
  }
  
  @objc private func handlePanGesture(gesture: UIPanGestureRecognizer) {
    let translation = gesture.translation(in: view)
    let newHeight = currentContainerHeight - translation.y
    
    switch gesture.state {
    case .changed:
      if newHeight <= maxHeight {
        containerViewHeightConstraint?.layoutConstraints[0].constant = newHeight
      }
    case .ended:
      currentContainerHeight = newHeight
      if newHeight > defaultHeight {
        self.animateMaxHeight()
      } else if newHeight < dismissableHeight {
        self.animateDismissView()
      } else if newHeight < defaultHeight {
        self.animateContainerHeight(defaultHeight)
      }
    default:
      break
    }
  }
  
  private func animateMaxHeight() {
    UIView.animate(withDuration: 0.3) {
      self.containerViewHeightConstraint?.layoutConstraints[0].constant = self.maxHeight
      self.view.layoutIfNeeded()
    }
  }
  
  // MARK: - Private methods
  private func animateDismissView() {
    UIView.animate(withDuration: 0.3) {
      self.conatinerViewBottomConstraint?.layoutConstraints[0].constant = self.defaultHeight
      self.view.layoutIfNeeded()
    }
    dimmedView.alpha = maxDimmedAlpha
    UIView.animate(withDuration: 0.4) {
      self.dimmedView.alpha = 0
    } completion: { [weak self] _ in
      self?.viewModel.dismiss()
    }
  }
  
  private func animateShowDimmedView() {
    dimmedView.alpha = 0
    UIView.animate(withDuration: 0.4) {
      self.dimmedView.alpha = self.maxDimmedAlpha
    }
  }
  
  private func animateShowContainerView() {
    UIView.animate(withDuration: 0.3) {
      self.conatinerViewBottomConstraint?.layoutConstraints[0].constant = 0
      self.view.layoutIfNeeded()
    }
  }
  
  private func animateContainerHeight(_ height: CGFloat) {
    UIView.animate(withDuration: 0.4) {
      self.containerViewHeightConstraint?.layoutConstraints[0].constant = height
      self.view.layoutIfNeeded()
    }
    currentContainerHeight = height
  }
  
  // MARK: - Bindables
  private func setupBindables() {
    viewModel.onNeedsToUpdateTableView = { [weak self] in
      self?.tableView.reloadData()
    }
  }
}

// MARK: - TableViewDataSourceDelegate
extension CardDetailViewController: TableViewDataSourceDelegate {
  func tableViewDataSource(_ dateSource: TableViewDataSource, heightForHeaderInSection section: Int) -> CGFloat? {
    return viewModel.isFirstSection(section) ? 45 : 60
  }
  
  func tableViewDataSource(_ dateSource: TableViewDataSource, heightForFooterInSection section: Int) -> CGFloat? {
    return 0
  }
}
