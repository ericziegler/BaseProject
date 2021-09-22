//
//  ColorComponents.swift
//
//  Created by Eric Ziegler
//

import UIKit

extension UITraitCollection {

    class var lightTraitCollection: UITraitCollection {
        return UITraitCollection(userInterfaceStyle: .light)
    }

    class var darkTraitCollection: UITraitCollection {
        return UITraitCollection(userInterfaceStyle: .dark)
    }

}

extension UIColor {

    class func appMain(for traitCollection: UITraitCollection) -> UIColor {
        return UIColor(hex: 0x00adb5)
    }

    class func appBackground(for traitCollection: UITraitCollection) -> UIColor {
        if traitCollection.userInterfaceStyle == .dark {
            return UIColor(hex: 0x000000)
        } else {
            return UIColor(hex: 0xffffff)
        }
    }

    class func appBar(for traitCollection: UITraitCollection) -> UIColor {
        if traitCollection.userInterfaceStyle == .dark {
            return UIColor(hex: 0x1a1a1a)
        } else {
            return UIColor(hex: 0xf9f9f9)
        }
    }

    class func appText(for traitCollection: UITraitCollection) -> UIColor {
        if traitCollection.userInterfaceStyle == .dark {
            return UIColor(hex: 0xffffff)
        } else {
            return UIColor(hex: 0x000000)
        }
    }

    class func appTextSecondary(for traitCollection: UITraitCollection) -> UIColor {
        if traitCollection.userInterfaceStyle == .dark {
            return UIColor(hex: 0x777777)
        } else {
            return UIColor(hex: 0x888888)
        }
    }

    class func appSeparator(for traitCollection: UITraitCollection) -> UIColor {
        if traitCollection.userInterfaceStyle == .dark {
            return UIColor(hex: 0x262626)
        } else {
            return UIColor(hex: 0xd9d9d9)
        }
    }

    class func appSelection(for traitCollection: UITraitCollection) -> UIColor {
        if traitCollection.userInterfaceStyle == .dark {
            return UIColor(hex: 0x111111)
        } else {
            return UIColor(hex: 0xeeeeee)
        }
    }

    class func appPlaceholder(for traitCollection: UITraitCollection) -> UIColor {
        if traitCollection.userInterfaceStyle == .dark {
            return UIColor(hex: 0x333333)
        } else {
            return UIColor(hex: 0xdddddd)
        }
    }

}
