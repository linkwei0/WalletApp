//
//  BaseViewController.swift
//  WalletApp
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    view.backgroundColor = .accent
  }
}
