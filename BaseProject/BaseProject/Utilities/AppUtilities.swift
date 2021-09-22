//
//  AppUtilities.swift
//
//  Created by Eric Ziegler
//

import UIKit

// MARK: - App Versions

var appVersion: String? {
    return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
}

var appBuild: String? {
    return Bundle.main.infoDictionary?["CFBundleVersion"] as? String
}

// MARK: Global UI Properties

func applyApplicationAppearanceProperties(for traitCollection: UITraitCollection) {
    UINavigationBar.appearance().tintColor = UIColor.appText(for: traitCollection)
    UINavigationBar.appearance().barTintColor = UIColor.appBackground(for: traitCollection)
//    UISearchBar.appearance().setBackgroundImage(UIImage.from(color: UIColor(hex: 0xf4f4f7)), for: .any, barMetrics: .default)
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont.appMediumFontOfSize(11)], for: .normal)
}

func navTitleTextAttributes(for traitCollection: UITraitCollection) -> [NSAttributedString.Key : Any] {
    return [NSAttributedString.Key.font : UIFont.appMediumFontOfSize(17), .foregroundColor : UIColor.appText(for: traitCollection)]
}

func navLargeTitleTextAttributes(for traitCollection: UITraitCollection) -> [NSAttributedString.Key : Any] {
    return [NSAttributedString.Key.font : UIFont.appMediumFontOfSize(34), .foregroundColor : UIColor.appText(for: traitCollection)]
}
