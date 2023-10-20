//
//  UIColor+AppColors.swift
//  WalletApp
//

import UIKit
import Rswift

extension UIColor {
  static let baseWhite = UIColor(resource: R.color.baseWhite) ?? .clear
  static let baseBlack = UIColor(resource: R.color.baseBlack) ?? .clear
  static let zeroBlack = UIColor(resource: R.color.zeroBlack) ?? .clear

  static let accent = UIColor(resource: R.color.accent) ?? .clear
  static let accentLight = UIColor(resource: R.color.accentLight) ?? .clear
  static let accentDark = UIColor(resource: R.color.accentDark) ?? .clear
  static let accentFaded = UIColor(resource: R.color.accentFaded) ?? .clear
  static let blueLight = UIColor(resource: R.color.blueLight) ?? .clear
  
  static let expenseBtnColor = UIColor(resource: R.color.expenseBtnColor) ?? .clear
  static let incomeBtnColor = UIColor(resource: R.color.incomeBtnColor) ?? .clear

  static let accentGreen = UIColor(resource: R.color.accentGreen) ?? .clear
  static let accentGreenLight = UIColor(resource: R.color.accentGreenLight) ?? .clear

  static let accentYellow = UIColor(resource: R.color.accentYellow) ?? .clear
  static let accentYellowLight = UIColor(resource: R.color.accentYellowLight) ?? .clear

  static let accentRed = UIColor(resource: R.color.accentRed) ?? .clear
  static let accentRedLight = UIColor(resource: R.color.accentRedLight) ?? .clear
  static let accentRedFaded = UIColor(resource: R.color.accentRedFaded) ?? .clear

  static let shade1 = UIColor(resource: R.color.shade1) ?? .clear
  static let shade2 = UIColor(resource: R.color.shade2) ?? .clear
  static let shade3 = UIColor(resource: R.color.shade3) ?? .clear
  static let shade4 = UIColor(resource: R.color.shade4) ?? .clear
  
  static let lessonTypeIndividual = UIColor(resource: R.color.lessonTypeIndividual) ?? .clear
  static let lessonTypeLaboratory = UIColor(resource: R.color.lessonTypeLaboratory) ?? .clear
  static let lessonTypeLecture = UIColor(resource: R.color.lessonTypeLecture) ?? .clear
  static let lessonTypeOtherWork = UIColor(resource: R.color.lessonTypeOtherWork) ?? .clear
  static let lessonTypePractice = UIColor(resource: R.color.lessonTypePractice) ?? .clear
  static let lessonTypeSeminar = UIColor(resource: R.color.lessonTypeSeminar) ?? .clear
  static let lessonTypeTestWork = UIColor(resource: R.color.lessonTypeTestWork) ?? .clear
}
