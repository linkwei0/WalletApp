//
//  BankViewController.swift
//  WalletApp
//

import UIKit

class BankViewController: BaseViewController {
  // MARK: - Properties
  
  private let mainPigImage = UIImageView()
  private let bankTitle = Label(textStyle: .header1)
  private let bottomBarView: BankBottomBarView
  
  private let viewModel: BankViewModel
  
  // MARK: - Init
  
  init(viewModel: BankViewModel) {
    self.viewModel = viewModel
    self.bottomBarView = BankBottomBarView(configuration: viewModel.bottomBarConfiguration)
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  // MARK: - Setups
  
  private func setup() {
    setupMainImage()
    setupBankTitle()
    setupBottomBarView()
  }
  
  private func setupMainImage() {
    view.addSubview(mainPigImage)
    mainPigImage.image = R.image.pigBankImage()
    mainPigImage.clipsToBounds = true
    mainPigImage.contentMode = .scaleAspectFit
    mainPigImage.snp.makeConstraints { make in
      make.centerY.equalToSuperview().offset(-72)
      make.leading.trailing.equalToSuperview().inset(72)
      make.size.equalTo(120).priority(750)
    }
  }
  
  private func setupBankTitle() {
    view.addSubview(bankTitle)
    bankTitle.text = viewModel.currentBank
    bankTitle.textAlignment = .center
    bankTitle.snp.makeConstraints { make in
      make.top.equalTo(mainPigImage.snp.bottom).offset(4)
      make.leading.trailing.equalToSuperview().inset(32)
    }
  }
  
  private func setupBottomBarView() {
    view.addSubview(bottomBarView)
    bottomBarView.onDidSelectItem = { [weak self] itemType in
      self?.viewModel.didSelectBottomBarItem(itemType)
    }
    bottomBarView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(16)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16).priority(750)
      make.bottom.greaterThanOrEqualToSuperview().offset(-40)
    }
  }
}
