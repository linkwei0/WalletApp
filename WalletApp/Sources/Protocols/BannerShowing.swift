//
//  BannerShowing.swift
//  WalletApp
//
//  Created by Артём Бацанов on 27.11.2023.
//

import UIKit
import NotificationBannerSwift

class BannerColors: BannerColorsProtocol {
  func color(for style: BannerStyle) -> UIColor {
    switch style {
    case .danger:
      return .accentRed
    case .info:
      return .accent
    case .customView:
      return .accent
    case .success:
      return .accentGreen
    case .warning:
      return .accentYellow
    }
  }
}

protocol BannerShowing {
  func showBanner(title: String?, subTitle: String?, style: BannerStyle)
}

extension BannerShowing {
  func showBanner(title: String?, subTitle: String?, style: BannerStyle) {
    let banner = FloatingNotificationBanner(title: title, subtitle: subTitle,
                                            titleFont: title == nil ? nil : .bodyBold,
                                            titleColor: title == nil ? nil : .baseWhite,
                                            subtitleFont: subTitle == nil ? nil : .body,
                                            subtitleColor: subTitle == nil ? nil : .baseWhite,
                                            style: style, colors: BannerColors())
    banner.bannerQueue.dismissAllForced()
    banner.show(edgeInsets: UIEdgeInsets(top: 24, left: 16, bottom: 16, right: 16),
                cornerRadius: 8, shadowColor: .baseBlack, shadowOpacity: 0.15, shadowBlurRadius: 24)
  }
}
