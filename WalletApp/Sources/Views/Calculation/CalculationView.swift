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
  private let expressionActionButton = UIButton(type: .system)
  
  private let viewModel: CalculationViewViewModel
  
  // MARK: - Init
  
  init(viewModel: CalculationViewViewModel) {
    self.viewModel = viewModel
    self.expressionView = ExpressionView(viewModel: viewModel.expressionViewModel,
                                         collectionType: viewModel.collectionType)
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder: NSCoder) {
    self.viewModel = CalculationViewViewModel(collectionType: .income)
    self.expressionView = ExpressionView(viewModel: viewModel.expressionViewModel, collectionType: .income)
    super.init(coder: coder)
    setup()
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    containerView.addShadow(offset: CGSize(width: 20, height: 20), radius: 6)
    containerView.cornerRadius(usingCorner: [.topLeft, .topRight], cornerRadius: CGSize(width: 26, height: 26))
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
      make.height.equalToSuperview().multipliedBy(0.695)
    }
  }
  
  private func setupAddButton() {
    containerView.addSubview(expressionActionButton)
    expressionActionButton.setTitle(viewModel.collectionType == .income ? Constants.addTitle : Constants.decreaseTitle,
                                    for: .normal)
    expressionActionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    expressionActionButton.setTitleColor(.baseWhite, for: .normal)
    expressionActionButton.backgroundColor = .accentDark
    expressionActionButton.layer.cornerRadius = 12
    expressionActionButton.layer.borderWidth = 2.0
    expressionActionButton.layer.borderColor = UIColor.baseWhite.cgColor
    expressionActionButton.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(60)
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
      make.leading.trailing.equalToSuperview().inset(12)
      make.bottom.equalTo(expressionActionButton.snp.top).offset(-10)
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
    let size = (self.frame.width - 80) / 4
    return CGSize(width: size, height: size)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
  }
}

private extension Constants {
  static let addTitle = "Добавить"
  static let decreaseTitle = "Убавить"
}
