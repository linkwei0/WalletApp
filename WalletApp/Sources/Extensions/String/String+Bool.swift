//
//  String+Bool.swift
//  WalletApp
//
//  Created by Артём Бацанов on 18.12.2023.
//

import Foundation

extension String {
  var isFractional: Bool {
    return self.contains(".")
  }
}
