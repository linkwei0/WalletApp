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
  
  private let buttonsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  private let customCalculationView: CustomCalculationView
  
  private let viewModel: CalculationViewViewModel
  
  // MARK: - Init
  
  init(viewModel: CalculationViewViewModel) {
    self.viewModel = viewModel
    self.customCalculationView = CustomCalculationView(viewModel: viewModel.customViewViewModel,
                                                       collectionType: viewModel.collectionType)
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder: NSCoder) {
    self.viewModel = CalculationViewViewModel(collectionType: .income)
    self.customCalculationView = CustomCalculationView(viewModel: viewModel.customViewViewModel, collectionType: .income)
    super.init(coder: coder)
    setup()
  }
  
  // MARK: - Setup
  
  private func setup() {
    setupCollectionView()
    setupCalculationMiddleView()
  }
  
  private func setupCalculationMiddleView() {
    addSubview(customCalculationView)
    customCalculationView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.trailing.equalToSuperview()
      make.bottom.equalTo(buttonsCollectionView.snp.top).offset(-8)
    }
  }
  
  private func setupCollectionView() {
    addSubview(buttonsCollectionView)
    buttonsCollectionView.dataSource = self
    buttonsCollectionView.delegate = self
    buttonsCollectionView.backgroundColor = .accent
    buttonsCollectionView.isScrollEnabled = false
    buttonsCollectionView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(12)
      make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(8)
      make.height.equalTo(325)
    }
    
    let layout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0)
    buttonsCollectionView.collectionViewLayout = layout
    buttonsCollectionView.register(CalculationCollectionCell.self,
                                   forCellWithReuseIdentifier: CalculationCollectionCell.reuseIdentifiable)
  }
}

// MARK: - UICollectionViewDataSource

extension CalculationView: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 4
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView
      .dequeueReusableCell(withReuseIdentifier: CalculationCollectionCell.reuseIdentifiable,
                           for: indexPath) as? CalculationCollectionCell else { return UICollectionViewCell() }
    cell.configure(with: viewModel.configureItemType(indexPath))
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CalculationView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 70, height: 70)
  }
}
