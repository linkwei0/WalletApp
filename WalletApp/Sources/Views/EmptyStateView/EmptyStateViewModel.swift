//
//  EmptyStateViewModel.swift
//  WalletApp
//
//  Created by Артём Бацанов on 30.10.2023.
//

import UIKit

struct EmptyStateViewModel {
  let image: UIImage?
  let imageSize: CGSize?
  let title: String?
  let subtitle: String?
  let additionalText: String?
  let additionalTextFont: UIFont?
  
  var shouldHideImage: Bool {
    image == nil
  }
  
  var shouldHideTitle: Bool {
    return false
  }
  
  var shouldHideSubtitle: Bool {
    return false
  }
  
  var shouldHideAdditionalText: Bool {
    return false
  }
  
  init(image: UIImage?, imageSize: CGSize?, title: String?, subtitle: String?,
       additionalText: String? = nil, additionalTextFont: UIFont? = nil) {
    self.image = image
    self.imageSize = imageSize
    self.title = title
    self.subtitle = subtitle
    self.additionalText = additionalText
    self.additionalTextFont = additionalTextFont
  }
}
