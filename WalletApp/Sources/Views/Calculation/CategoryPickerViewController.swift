//
//  CategoryPickerViewController.swift
//  WalletApp
//

import UIKit

class CategoryPickerViewController: BaseViewController {
  // MARK: - Properties
  var onDidSelectCategory: ((String) -> Void)?
  
  private let overlayView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
  private let amountLabel = Label(textStyle: .header1)
  private let containerView = UIView()
  private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  private let titleLabel = Label(textStyle: .bodyBold)
  private let cancelButton = UIButton(type: .system)
  private let bottomSpaceView = UIView()
  
  let viewModel: CategoryPickerViewModel
  
  // MARK: - Init
  init(viewModel: CategoryPickerViewModel) {
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
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    animateAppearance()
  }
  
  // MARK: - Setup
  private func setup() {
    setupOverlayView()
    setupAmountLabel()
    setupContainerView()
    setupTitleLabel()
    setupCancelButton()
    setupCollectionView()
    setupBottomSpaceView()
  }
  
  private func setupOverlayView() {
    view.addSubview(overlayView)
    overlayView.layer.cornerRadius = 16
    overlayView.clipsToBounds = true
    overlayView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeCategoryPicker)))
    overlayView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  private func setupAmountLabel() {
    view.addSubview(amountLabel)
    amountLabel.textColor = .baseWhite
    amountLabel.textAlignment = .center
    amountLabel.numberOfLines = 0
    amountLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(86)
      make.leading.trailing.equalToSuperview()
    }
  }
  
  private func setupContainerView() {
    view.addSubview(containerView)
    containerView.backgroundColor = .baseWhite
    containerView.layer.cornerRadius = 16
    containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    makeClosedStateConstraints()
  }
  
  private func setupTitleLabel() {
    containerView.addSubview(titleLabel)
    titleLabel.text = "Категории"
    titleLabel.textColor = .baseBlack
    titleLabel.snp.makeConstraints { make in
      make.top.leading.equalToSuperview().inset(16)
    }
  }
  
  private func setupCancelButton() {
    containerView.addSubview(cancelButton)
    cancelButton.setTitle("Закрыть", for: .normal)
    cancelButton.setTitleColor(.accentDark, for: .normal)
    cancelButton.addTarget(self, action: #selector(closeCategoryPicker), for: .touchUpInside)
    cancelButton.snp.makeConstraints { make in
      make.trailing.equalToSuperview().inset(16)
      make.centerY.equalTo(titleLabel)
    }
  }
  
  private func setupBottomSpaceView() {
    view.addSubview(bottomSpaceView)
    bottomSpaceView.backgroundColor = .baseWhite
    bottomSpaceView.snp.makeConstraints { make in
      make.top.equalTo(collectionView.snp.bottom)
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(view.snp.height)
    }
  }
  
  private func setupCollectionView() {
    containerView.addSubview(collectionView)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = .baseWhite
    collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseIdentifiable)
    collectionView.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(12)
      make.leading.trailing.equalToSuperview()
      make.bottom.equalToSuperview()
    }
  }
  
  // MARK: - Private methods
  private func animateAppearance() {
    makeOpenedStateConstraints()
    
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
      self.overlayView.alpha = 0.5
      self.view.layoutIfNeeded()
    }, completion: nil)
  }
  
  private func animateDisappearance() {
    makeClosedStateConstraints()
    
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
      self.overlayView.alpha = 0
      self.view.layoutIfNeeded()
    } completion: { _ in
      self.dismiss(animated: false)
    }
  }
  
  private func makeOpenedStateConstraints() {
    containerView.snp.remakeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
      make.height.equalToSuperview().multipliedBy(0.5)
    }
  }
  
  private func makeClosedStateConstraints() {
    containerView.snp.remakeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(view.snp.bottom)
      make.height.equalToSuperview().multipliedBy(0.5)
    }
  }
  
  // MARK: - Actions
  @objc private func closeCategoryPicker() {
    animateDisappearance()
  }
  
  // MARK: - Bindables
  private func setupBindables() {
    viewModel.operationAmountValue.bindAndFire { [weak self] amountValue in
      self?.amountLabel.text = amountValue
    }
    viewModel.isCreateOperation.bind { [weak self] _ in
      self?.closeCategoryPicker()
    }
  }
}

extension CategoryPickerViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return viewModel.numberOfSections()
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.numberOfItemsInSection(section: section)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseIdentifiable,
                                                        for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
    cell.configure(with: viewModel.configureItemType(indexPath))
    return cell
  }
}

extension CategoryPickerViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    viewModel.didSelectedCategory(at: indexPath)
  }
}

extension CategoryPickerViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let size = (self.view.frame.width - 110) / 3
    return CGSize(width: size, height: size)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
  }
}
