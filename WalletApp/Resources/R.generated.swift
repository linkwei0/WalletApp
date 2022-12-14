//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try font.validate()
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 26 colors.
  struct color {
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")
    /// Color `accentDark`.
    static let accentDark = Rswift.ColorResource(bundle: R.hostingBundle, name: "accentDark")
    /// Color `accentFaded`.
    static let accentFaded = Rswift.ColorResource(bundle: R.hostingBundle, name: "accentFaded")
    /// Color `accentGreenLight`.
    static let accentGreenLight = Rswift.ColorResource(bundle: R.hostingBundle, name: "accentGreenLight")
    /// Color `accentGreen`.
    static let accentGreen = Rswift.ColorResource(bundle: R.hostingBundle, name: "accentGreen")
    /// Color `accentLight`.
    static let accentLight = Rswift.ColorResource(bundle: R.hostingBundle, name: "accentLight")
    /// Color `accentRedFaded`.
    static let accentRedFaded = Rswift.ColorResource(bundle: R.hostingBundle, name: "accentRedFaded")
    /// Color `accentRedLight`.
    static let accentRedLight = Rswift.ColorResource(bundle: R.hostingBundle, name: "accentRedLight")
    /// Color `accentRed`.
    static let accentRed = Rswift.ColorResource(bundle: R.hostingBundle, name: "accentRed")
    /// Color `accentYellowLight`.
    static let accentYellowLight = Rswift.ColorResource(bundle: R.hostingBundle, name: "accentYellowLight")
    /// Color `accentYellow`.
    static let accentYellow = Rswift.ColorResource(bundle: R.hostingBundle, name: "accentYellow")
    /// Color `accent`.
    static let accent = Rswift.ColorResource(bundle: R.hostingBundle, name: "accent")
    /// Color `baseBlack`.
    static let baseBlack = Rswift.ColorResource(bundle: R.hostingBundle, name: "baseBlack")
    /// Color `baseWhite`.
    static let baseWhite = Rswift.ColorResource(bundle: R.hostingBundle, name: "baseWhite")
    /// Color `lessonTypeIndividual`.
    static let lessonTypeIndividual = Rswift.ColorResource(bundle: R.hostingBundle, name: "lessonTypeIndividual")
    /// Color `lessonTypeLaboratory`.
    static let lessonTypeLaboratory = Rswift.ColorResource(bundle: R.hostingBundle, name: "lessonTypeLaboratory")
    /// Color `lessonTypeLecture`.
    static let lessonTypeLecture = Rswift.ColorResource(bundle: R.hostingBundle, name: "lessonTypeLecture")
    /// Color `lessonTypeOtherWork`.
    static let lessonTypeOtherWork = Rswift.ColorResource(bundle: R.hostingBundle, name: "lessonTypeOtherWork")
    /// Color `lessonTypePractice`.
    static let lessonTypePractice = Rswift.ColorResource(bundle: R.hostingBundle, name: "lessonTypePractice")
    /// Color `lessonTypeSeminar`.
    static let lessonTypeSeminar = Rswift.ColorResource(bundle: R.hostingBundle, name: "lessonTypeSeminar")
    /// Color `lessonTypeTestWork`.
    static let lessonTypeTestWork = Rswift.ColorResource(bundle: R.hostingBundle, name: "lessonTypeTestWork")
    /// Color `shade1`.
    static let shade1 = Rswift.ColorResource(bundle: R.hostingBundle, name: "shade1")
    /// Color `shade2`.
    static let shade2 = Rswift.ColorResource(bundle: R.hostingBundle, name: "shade2")
    /// Color `shade3`.
    static let shade3 = Rswift.ColorResource(bundle: R.hostingBundle, name: "shade3")
    /// Color `shade4`.
    static let shade4 = Rswift.ColorResource(bundle: R.hostingBundle, name: "shade4")
    /// Color `zeroBlack`.
    static let zeroBlack = Rswift.ColorResource(bundle: R.hostingBundle, name: "zeroBlack")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "accent", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accent(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accent, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "accentDark", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentDark(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentDark, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "accentFaded", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentFaded(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentFaded, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "accentGreen", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentGreen(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentGreen, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "accentGreenLight", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentGreenLight(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentGreenLight, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "accentLight", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentLight(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentLight, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "accentRed", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentRed(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentRed, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "accentRedFaded", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentRedFaded(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentRedFaded, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "accentRedLight", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentRedLight(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentRedLight, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "accentYellow", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentYellow(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentYellow, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "accentYellowLight", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentYellowLight(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentYellowLight, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "baseBlack", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func baseBlack(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.baseBlack, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "baseWhite", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func baseWhite(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.baseWhite, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "lessonTypeIndividual", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func lessonTypeIndividual(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.lessonTypeIndividual, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "lessonTypeLaboratory", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func lessonTypeLaboratory(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.lessonTypeLaboratory, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "lessonTypeLecture", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func lessonTypeLecture(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.lessonTypeLecture, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "lessonTypeOtherWork", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func lessonTypeOtherWork(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.lessonTypeOtherWork, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "lessonTypePractice", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func lessonTypePractice(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.lessonTypePractice, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "lessonTypeSeminar", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func lessonTypeSeminar(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.lessonTypeSeminar, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "lessonTypeTestWork", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func lessonTypeTestWork(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.lessonTypeTestWork, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "shade1", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func shade1(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.shade1, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "shade2", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func shade2(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.shade2, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "shade3", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func shade3(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.shade3, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "shade4", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func shade4(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.shade4, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "zeroBlack", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func zeroBlack(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.zeroBlack, compatibleWith: traitCollection)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "accent", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accent(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accent.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "accentDark", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentDark(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentDark.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "accentFaded", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentFaded(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentFaded.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "accentGreen", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentGreen(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentGreen.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "accentGreenLight", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentGreenLight(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentGreenLight.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "accentLight", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentLight(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentLight.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "accentRed", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentRed(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentRed.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "accentRedFaded", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentRedFaded(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentRedFaded.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "accentRedLight", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentRedLight(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentRedLight.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "accentYellow", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentYellow(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentYellow.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "accentYellowLight", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentYellowLight(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentYellowLight.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "baseBlack", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func baseBlack(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.baseBlack.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "baseWhite", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func baseWhite(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.baseWhite.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "lessonTypeIndividual", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func lessonTypeIndividual(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.lessonTypeIndividual.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "lessonTypeLaboratory", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func lessonTypeLaboratory(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.lessonTypeLaboratory.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "lessonTypeLecture", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func lessonTypeLecture(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.lessonTypeLecture.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "lessonTypeOtherWork", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func lessonTypeOtherWork(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.lessonTypeOtherWork.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "lessonTypePractice", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func lessonTypePractice(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.lessonTypePractice.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "lessonTypeSeminar", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func lessonTypeSeminar(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.lessonTypeSeminar.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "lessonTypeTestWork", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func lessonTypeTestWork(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.lessonTypeTestWork.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "shade1", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func shade1(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.shade1.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "shade2", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func shade2(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.shade2.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "shade3", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func shade3(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.shade3.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "shade4", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func shade4(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.shade4.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "zeroBlack", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func zeroBlack(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.zeroBlack.name)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.entitlements` struct is generated, and contains static references to 1 properties.
  struct entitlements {
    static let apsEnvironment = infoPlistString(path: [], key: "aps-environment") ?? "development"

    fileprivate init() {}
  }

  /// This `R.file` struct is generated, and contains static references to 3 files.
  struct file {
    /// Resource file `GoogleService-Info.plist`.
    static let googleServiceInfoPlist = Rswift.FileResource(bundle: R.hostingBundle, name: "GoogleService-Info", pathExtension: "plist")
    /// Resource file `Manrope-ExtraBold.ttf`.
    static let manropeExtraBoldTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Manrope-ExtraBold", pathExtension: "ttf")
    /// Resource file `Manrope-Regular.ttf`.
    static let manropeRegularTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Manrope-Regular", pathExtension: "ttf")

    /// `bundle.url(forResource: "GoogleService-Info", withExtension: "plist")`
    static func googleServiceInfoPlist(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.googleServiceInfoPlist
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Manrope-ExtraBold", withExtension: "ttf")`
    static func manropeExtraBoldTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.manropeExtraBoldTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Manrope-Regular", withExtension: "ttf")`
    static func manropeRegularTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.manropeRegularTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.font` struct is generated, and contains static references to 2 fonts.
  struct font: Rswift.Validatable {
    /// Font `Manrope-ExtraBold`.
    static let manropeExtraBold = Rswift.FontResource(fontName: "Manrope-ExtraBold")
    /// Font `Manrope-Regular`.
    static let manropeRegular = Rswift.FontResource(fontName: "Manrope-Regular")

    /// `UIFont(name: "Manrope-ExtraBold", size: ...)`
    static func manropeExtraBold(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: manropeExtraBold, size: size)
    }

    /// `UIFont(name: "Manrope-Regular", size: ...)`
    static func manropeRegular(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: manropeRegular, size: size)
    }

    static func validate() throws {
      if R.font.manropeExtraBold(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Manrope-ExtraBold' could not be loaded, is 'Manrope-ExtraBold.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.manropeRegular(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Manrope-Regular' could not be loaded, is 'Manrope-Regular.ttf' added to the UIAppFonts array in this targets Info.plist?") }
    }

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 1 images.
  struct image {
    /// Image `pig-bank-image`.
    static let pigBankImage = Rswift.ImageResource(bundle: R.hostingBundle, name: "pig-bank-image")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "pig-bank-image", bundle: ..., traitCollection: ...)`
    static func pigBankImage(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.pigBankImage, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.info` struct is generated, and contains static references to 1 properties.
  struct info {
    struct uiApplicationSceneManifest {
      static let _key = "UIApplicationSceneManifest"
      static let uiApplicationSupportsMultipleScenes = false

      struct uiSceneConfigurations {
        static let _key = "UISceneConfigurations"

        struct uiWindowSceneSessionRoleApplication {
          struct defaultConfiguration {
            static let _key = "Default Configuration"
            static let uiSceneConfigurationName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneConfigurationName") ?? "Default Configuration"
            static let uiSceneDelegateClassName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneDelegateClassName") ?? "$(PRODUCT_MODULE_NAME).SceneDelegate"

            fileprivate init() {}
          }

          fileprivate init() {}
        }

        fileprivate init() {}
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.bank` struct is generated, and contains static references to 4 localization keys.
    struct bank {
      /// Value: ??????????????????
      static let bankBottomBarExpenseTitle = Rswift.StringResource(key: "bank.bottom.bar.expense.title", tableName: "Bank", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: ??????????????
      static let bankTitle = Rswift.StringResource(key: "bank.title", tableName: "Bank", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: ????????????????
      static let bankBottomBarIncomeTitle = Rswift.StringResource(key: "bank.bottom.bar.income.title", tableName: "Bank", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: ??????????????
      static let bankBottomBarProfileTitle = Rswift.StringResource(key: "bank.bottom.bar.profile.title", tableName: "Bank", bundle: R.hostingBundle, locales: [], comment: nil)

      /// Value: ??????????????????
      static func bankBottomBarExpenseTitle(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("bank.bottom.bar.expense.title", tableName: "Bank", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Bank", preferredLanguages: preferredLanguages) else {
          return "bank.bottom.bar.expense.title"
        }

        return NSLocalizedString("bank.bottom.bar.expense.title", tableName: "Bank", bundle: bundle, comment: "")
      }

      /// Value: ??????????????
      static func bankTitle(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("bank.title", tableName: "Bank", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Bank", preferredLanguages: preferredLanguages) else {
          return "bank.title"
        }

        return NSLocalizedString("bank.title", tableName: "Bank", bundle: bundle, comment: "")
      }

      /// Value: ????????????????
      static func bankBottomBarIncomeTitle(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("bank.bottom.bar.income.title", tableName: "Bank", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Bank", preferredLanguages: preferredLanguages) else {
          return "bank.bottom.bar.income.title"
        }

        return NSLocalizedString("bank.bottom.bar.income.title", tableName: "Bank", bundle: bundle, comment: "")
      }

      /// Value: ??????????????
      static func bankBottomBarProfileTitle(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("bank.bottom.bar.profile.title", tableName: "Bank", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Bank", preferredLanguages: preferredLanguages) else {
          return "bank.bottom.bar.profile.title"
        }

        return NSLocalizedString("bank.bottom.bar.profile.title", tableName: "Bank", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
