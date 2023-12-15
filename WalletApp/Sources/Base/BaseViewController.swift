//
//  BaseViewController.swift
//  WalletApp
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    view.backgroundColor = .baseWhite
  }
}
