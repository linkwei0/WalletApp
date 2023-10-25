//
//  CalculationView.swift
//  WalletApp
//

import UIKit

enum CollectionType {
  case income, expense
}

class CalculationView: UIView {
  // MARK: - Properties
  private let containerView = UIView()
  private let buttonsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  private let expressionView: ExpressionView
  private let createOperationButton = UIButton(type: .system)
  
  private let viewModel: CalculationViewModel
  
  // MARK: - Init
  init(viewModel: CalculationViewModel) {
    self.viewModel = viewModel
    self.expressionView = ExpressionView(viewModel: viewModel.expressionViewModel,
                                         collectionType: viewModel.collectionType)
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    containerView.cornerRadius(usingCorner: [.topLeft, .topRight], cornerRadius: CGSize(width: 24, height: 24))
  }
  
  // MARK: - Setup
  private func setup() {
    setupContainerView()
    setupAddButton()
    setupCollectionView()
    setupExpressionView()
  }
  
  private func setupContainerView() {
    addSubview(containerView)
    containerView.backgroundColor = .accent
    containerView.snp.makeConstraints { make in
      make.bottom.leading.trailing.equalToSuperview()
      make.height.equalToSuperview().multipliedBy(0.515)
    }
  }
  
  private func setupAddButton() {
    containerView.addSubview(createOperationButton)
    createOperationButton.setTitle(viewModel.collectionType == .income ? Constants.increaseTitle
                                   : Constants.decreaseTitle, for: .normal)
    createOperationButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    createOperationButton.setTitleColor(.baseWhite, for: .normal)
    createOperationButton.backgroundColor = .accentDark
    createOperationButton.layer.cornerRadius = 12
    createOperationButton.layer.borderWidth = 1.5
    createOperationButton.layer.borderColor = UIColor.baseWhite.cgColor
    createOperationButton.addTarget(self, action: #selector(didTapCreateOperationButton), for: .touchUpInside)
    createOperationButton.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(44)
      make.height.equalTo(45)
      make.bottom.equalToSuperview().inset(32)
    }
  }
    
  private func setupCollectionView() {
    containerView.addSubview(buttonsCollectionView)
    buttonsCollectionView.dataSource = self
    buttonsCollectionView.delegate = self
    buttonsCollectionView.backgroundColor = .accent
    buttonsCollectionView.isScrollEnabled = false
    buttonsCollectionView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(6)
      make.leading.trailing.equalToSuperview().inset(46)
      make.bottom.equalTo(createOperationButton.snp.top).offset(-10)
    }
    
    let layout = UICollectionViewFlowLayout()
    buttonsCollectionView.collectionViewLayout = layout
    buttonsCollectionView.register(CalculationCell.self,
                                   forCellWithReuseIdentifier: CalculationCell.reuseIdentifiable)
  }
  
  private func setupExpressionView() {
    addSubview(expressionView)
    expressionView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.trailing.equalToSuperview().inset(16)
      make.bottom.equalTo(containerView.snp.top).offset(-4)
    }
  }
  
  // MARK: - Actions
  @objc private func didTapCreateOperationButton() {
//    let categoryPickerController = CategoryPickerViewController()
//    categoryPickerController.modalPresentationStyle = .overCurrentContext
//    categoryPickerController.onDidSelectCategory = { [weak self] category in
//      self?.viewModel.didSelectCategory(category)
//    }
//    present(categoryPickerController, animated: false)
    viewModel.didTapCreateOperationButton()
  }
}

// MARK: - UICollectionViewDataSource
extension CalculationView: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView
      .dequeueReusableCell(withReuseIdentifier: CalculationCell.reuseIdentifiable,
                           for: indexPath) as? CalculationCell else { return UICollectionViewCell() }
    cell.configure(with: viewModel.configureItemType(indexPath))
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CalculationView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let size = (self.frame.width - 175) / 4
    return CGSize(width: size, height: size)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
  }
}

private extension Constants {
  static let increaseTitle = "Добавить"
  static let decreaseTitle = "Убавить"
}
