//
//  BaseNavigationController.swift
//
//  Created by Eric Ziegler
//

import UIKit

// MARK: - Enums

enum NavigationTransition {
    case none
    case fade
    case fromBottom
    case fromTop
}

// MARK: - TypeAliases

typealias NavigationCompletionBlock = () -> ()

class BaseNavigationController: UINavigationController, UINavigationControllerDelegate {

    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        applyApplicationAppearanceProperties(for: traitCollection)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    // MARK: -  UIViewController

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.navigationBar.tintColor = UIColor.appText(for: traitCollection)
        self.navigationBar.barTintColor = UIColor.appBackground(for: traitCollection)
    }

    // MARK: - Navigation

    func pushViewController(_ viewController: UIViewController, transition: NavigationTransition, completion: NavigationCompletionBlock? = nil) {
        let transitionDuration = setupNavigationAnimationFor(type: transition)
        self.pushViewController(viewController, animated: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + transitionDuration) {
            completion?()
        }
    }

    func popViewController(transition: NavigationTransition, completion: NavigationCompletionBlock? = nil) {
        let transitionDuration = setupNavigationAnimationFor(type: transition)
        self.popViewController(animated: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + transitionDuration) {
            completion?()
        }
    }

    func popToRootViewController(transition: NavigationTransition, completion: NavigationCompletionBlock? = nil) {
        let transitionDuration = setupNavigationAnimationFor(type: transition)
        self.popToRootViewController(animated: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + transitionDuration) {
            completion?()
        }
    }

    private func setupNavigationAnimationFor(type: NavigationTransition, completion: NavigationCompletionBlock? = nil) -> TimeInterval {
        if type == .none {
            return 0
        }

        let transition:CATransition = CATransition()
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        if type == .fade {
            transition.duration = 0.4
            transition.type = .fade
        }
        else if type == .fromBottom {
            transition.duration = 0.5
            transition.type = .push
            transition.subtype = .fromBottom
        }
        else if type == .fromTop {
            transition.duration = 0.5
            transition.type = .push
            transition.subtype = .fromTop
        }
        self.view.layer.add(transition, forKey: kCATransition)
        return transition.duration
    }

    // MARK: - UINavigationControllerDelegate

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        // customize back button
        let backImage = UIImage(named: "Back")?.maskedWithColor(UIColor.appText(for: self.traitCollection))
        viewController.navigationController?.navigationBar.backIndicatorImage = backImage
        viewController.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage

        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
    }

}
