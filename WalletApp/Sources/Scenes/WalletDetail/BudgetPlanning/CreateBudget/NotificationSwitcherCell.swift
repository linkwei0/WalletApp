//
//  NotificationSwitcherCell.swift
//  WalletApp
//
//  Created by Артём Бацанов on 23.11.2023.
//

import UIKit

class NotificationSwitcherCell: UITableViewCell, TableCell {
  // MARK: - Properties
  private let titleLabel = Label(textStyle: .body)
  private let notificationSwitch = UISwitch()
  private let separatorLine = UIView()
  
  private var viewModel: NotificationSwitcherCellViewModel?
  
  // MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  // MARK: - Configure
  func configure(with viewModel: TableCellViewModel) {
    guard let viewModel = viewModel as? NotificationSwitcherCellViewModel else { return }
    self.viewModel = viewModel
  }
  
  // MARK: - Setup
  private func setup() {
    setupBackground()
    setupTitleLabel()
    setupNotificationSwitch()
    setupSeparatorLine()
  }
  
  private func setupBackground() {
    selectionStyle = .none
  }
  
  private func setupTitleLabel() {
    contentView.addSubview(titleLabel)
    titleLabel.textColor = .baseBlack
    titleLabel.textAlignment = .left
    titleLabel.text = "Если превысил 80% уведомить"
    titleLabel.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(8)
      make.leading.equalToSuperview().inset(24)
    }
  }
  
  private func setupNotificationSwitch() {
    contentView.addSubview(notificationSwitch)
    notificationSwitch.isOn = false
    notificationSwitch.addTarget(self, action: #selector(switcherDidChange(_:)), for: .valueChanged)
    notificationSwitch.snp.makeConstraints { make in
      make.trailing.equalToSuperview().inset(24)
      make.centerY.equalToSuperview()
    }
  }
  
  private func setupSeparatorLine() {
    contentView.addSubview(separatorLine)
    separatorLine.backgroundColor = .shade3
    separatorLine.snp.makeConstraints { make in
      make.bottom.equalToSuperview()
      make.leading.trailing.equalToSuperview().inset(24)
      make.height.equalTo(0.5)
    }
  }
  
  // MARK: - Actions
  @objc private func switcherDidChange(_ sender: UISwitch) {
    viewModel?.switcherDidChange(sender.isOn)
  }
}
