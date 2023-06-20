//
//  UIColor+AppColors.swift
//  WalletApp
//

import UIKit
import Rswift

extension UIColor {
  static let baseWhite = R.color.baseWhite.uiColor
  static let baseBlack = R.color.baseBlack.uiColor
  static let zeroBlack = R.color.zeroBlack.uiColor

  static let accent = R.color.accent.uiColor
  static let accentLight = R.color.accentLight.uiColor
  static let accentDark = R.color.accentDark.uiColor
  static let accentFaded = R.color.accentFaded.uiColor
  static let blueLight = R.color.blueLight.uiColor

  static let accentGreen = R.color.accentGreen.uiColor
  static let accentGreenLight = R.color.accentGreenLight.uiColor

  static let accentYellow = R.color.accentYellow.uiColor
  static let accentYellowLight = R.color.accentYellowLight.uiColor

  static let accentRed = R.color.accentRed.uiColor
  static let accentRedLight = R.color.accentRedLight.uiColor
  static let accentRedFaded = R.color.accentRedFaded.uiColor

  static let shade1 = R.color.shade1.uiColor
  static let shade2 = R.color.shade2.uiColor
  static let shade3 = R.color.shade3.uiColor
  static let shade4 = R.color.shade4.uiColor
  
  static let lessonTypeIndividual = R.color.lessonTypeIndividual.uiColor
  static let lessonTypeLaboratory = R.color.lessonTypeLaboratory.uiColor
  static let lessonTypeLecture = R.color.lessonTypeLecture.uiColor
  static let lessonTypeOtherWork = R.color.lessonTypeOtherWork.uiColor
  static let lessonTypePractice = R.color.lessonTypePractice.uiColor
  static let lessonTypeSeminar = R.color.lessonTypeSeminar.uiColor
  static let lessonTypeTestWork = R.color.lessonTypeTestWork.uiColor
}

extension ColorResource {
  var uiColor: UIColor {
    return UIColor(resource: self) ?? .clear
  }
}
