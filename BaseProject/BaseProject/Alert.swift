//
//  Alert.swift
//

import UIKit

// MARK: - Constants

typealias AlertCompletionBlock = () -> ()

extension UIColor {
    class var alertButtonBlue: UIColor {
        return UIColor(hex: 0x15b0f0)
    }

    class var alertButtonRed: UIColor {
        return UIColor(hex: 0xd03227)
    }
}

class Alert: UIView {

    // MARK: - Private Constants

    private let AlertAnimationInterval: TimeInterval = 0.2
    private let AlertCornerRadius: CGFloat = 8

    // MARK: - Properties

    @IBOutlet var alertBox: UIView!
    @IBOutlet var titleLabel: RegularLabel!
    @IBOutlet var messageLabel: LightLabel!
    @IBOutlet var singleButton: RegularButton!
    @IBOutlet var leftButton: RegularButton!
    @IBOutlet var rightButton: RegularButton!
    @IBOutlet var verticalSeparator: UIView!

    var title = ""
    var message: String?
    private var buttons = [(title: String, color: UIColor)]()
    private var buttonCompletions = [AlertCompletionBlock]()

    // MARK: - Init

    static func createAlertFor(viewController: UIViewController, title: String, message: String?) -> Alert {
        let alert: Alert = UIView.fromNib()
        alert.fillInParentView(parentView: viewController.view)
        alert.title = title
        alert.message = message
        return alert
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        alertBox.layer.cornerRadius = AlertCornerRadius
    }

    // MARK: - Buttons

    func addButtonWith(_ text: String, color: UIColor = UIColor.alertButtonBlue, completion: @escaping AlertCompletionBlock) {
        buttons.append((title: text, color: color))
        buttonCompletions.append(completion)
    }

    private func layoutButtons() {
        singleButton.isHidden = true
        leftButton.isHidden = true
        rightButton.isHidden = true
        verticalSeparator.isHidden = true

        if buttons.count == 1 {
            singleButton.isHidden = false
            singleButton.setTitle(buttons[0].title, for: .normal)
            singleButton.setTitleColor(buttons[0].color, for: .normal)
            singleButton.tag = 0
        }
        else if buttons.count == 2 {
            leftButton.isHidden = false
            leftButton.setTitle(buttons[0].title, for: .normal)
            leftButton.setTitleColor(buttons[0].color, for: .normal)
            leftButton.tag = 0
            rightButton.isHidden = false
            rightButton.setTitle(buttons[1].title, for: .normal)
            rightButton.setTitleColor(buttons[1].color, for: .normal)
            rightButton.tag = 1
            verticalSeparator.isHidden = false
        }
    }

    // MARK: - Actions

    @IBAction func buttonTapped(_ sender: AnyObject) {
        hideAlert()
        if let button = sender as? RegularButton {
            buttonCompletions[button.tag]()
        }
    }

    // MARK: - Show / Hide

    func showAlert() {
        titleLabel.text = title
        messageLabel.text = message
        layoutButtons()
        self.alpha = 0
        UIView.animate(withDuration: AlertAnimationInterval) {
            self.alpha = 1
        }
    }

    func hideAlert() {
        UIView.animate(withDuration: AlertAnimationInterval, animations: {
            self.alpha = 0
        }) { (completed) in
            self.removeFromSuperview()
        }
    }

}
