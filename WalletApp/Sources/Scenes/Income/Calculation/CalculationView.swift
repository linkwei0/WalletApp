//
//  CalculationView.swift
//  WalletApp
//

import UIKit

class CalculationView: UIView {
  // MARK: - Properties
  
  private let buttonsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  private let calculationMiddleView = CustomCalculationView()
  
  private let viewModel = CalculationViewViewModel()
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
    calculationMiddleView.delegate = self
    bindViewModel()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup
  
  private func setup() {
    setupCollectionView()
    setupCalculationMiddleView()
  }
  
  private func setupCollectionView() {
    addSubview(buttonsCollectionView)
    buttonsCollectionView.dataSource = self
    buttonsCollectionView.delegate = self
    buttonsCollectionView.backgroundColor = .accent
    buttonsCollectionView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(450)
      make.leading.trailing.equalToSuperview().inset(12)
      make.bottom.equalToSuperview()
    }
    
    let layout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
    buttonsCollectionView.collectionViewLayout = layout
    buttonsCollectionView.register(CalculationItemCell.self, forCellWithReuseIdentifier: CalculationItemCell.reuseIdentifiable)
  }
  
  private func setupCalculationMiddleView() {
    addSubview(calculationMiddleView)
    calculationMiddleView.snp.makeConstraints { make in
      make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
      make.leading.trailing.equalToSuperview()
      make.bottom.equalTo(buttonsCollectionView.snp.top).offset(-8)
    }
  }
    
  // MARK: Bind ViewModel
  
  private func bindViewModel() {
    viewModel.onUpdateCurrentValue = { [weak self] currenValue in
      self?.calculationMiddleView.currentValueLabel.text = currenValue
    }
    
    viewModel.onUpdateAllValues = { [weak self] currentValue, currentSign in
      self?.calculationMiddleView.currentSignLabel.text = currentSign
      self?.calculationMiddleView.supportingValueLabel.text = currentValue
      self?.calculationMiddleView.currentValueLabel.text = ""
    }
    
    viewModel.onUpdateUIAfterEqual = { [weak self] resultValue in
      self?.calculationMiddleView.currentValueLabel.text = resultValue
      self?.calculationMiddleView.currentSignLabel.text = ""
      self?.calculationMiddleView.supportingValueLabel.text = ""
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
      .dequeueReusableCell(withReuseIdentifier: CalculationItemCell.reuseIdentifiable,
                           for: indexPath) as? CalculationItemCell else { return UICollectionViewCell() }
    cell.configure(with: viewModel.configureItemType(indexPath))
    return cell
  }
}

// MARK: - UICollectionViewDelegate

extension CalculationView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    viewModel.didUpdateCurrentValue(with: indexPath,
                                    prevValue: calculationMiddleView.currentValueLabel.text ?? "",
                                    resultValue: calculationMiddleView.supportingValueLabel.text ?? "",
                                    currentSign: calculationMiddleView.currentSignLabel.text ?? "")
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CalculationView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 80, height: 80)
  }
}

// MARK: - CustomCalculationViewDelegate

extension CalculationView: CustomCalculationViewDelegate {
  func didTapClearButton(_ view: CustomCalculationView, text: String) {
    viewModel.onDidTapClearButton(currentValue: text)
  }
  
  func didTapAllClearButton(_ view: CustomCalculationView) {
    viewModel.onDidTapAllClearButton()
  }
  
  func didTapCheckButton(_ view: CustomCalculationView, with value: String) {
    viewModel.onDidTapCheckButton(value)
  }
}
