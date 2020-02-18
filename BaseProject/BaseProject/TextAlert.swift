//
//  TextAlert.swift
//

import UIKit

class TextAlert: UIView {

    // MARK: - Private Constants

    private let AlertAnimationInterval: TimeInterval = 0.2
    private let AlertCornerRadius: CGFloat = 8

    // MARK: - Properties

    @IBOutlet var alertBox: UIView!
    @IBOutlet var titleLabel: RegularLabel!
    @IBOutlet var textField: StyledTextField!
    @IBOutlet var singleButton: RegularButton!
    @IBOutlet var leftButton: RegularButton!
    @IBOutlet var rightButton: RegularButton!
    @IBOutlet var verticalSeparator: UIView!

    var title = ""
    var placeholder: String?
    private var buttons = [(title: String, color: UIColor)]()
    private var buttonCompletions = [AlertCompletionBlock]()

    // MARK: - Init

    static func createAlertFor(viewController: UIViewController, title: String, placeholder: String?) -> TextAlert {
        let alert: TextAlert = UIView.fromNib()
        alert.fillInParentView(parentView: viewController.view)
        alert.title = title
        alert.placeholder = placeholder
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
        textField.placeholder = placeholder
        textField.styleBorderWithColor(color: UIColor.lightGray, cornerRadius: 1, borderWidth: 1)
        layoutButtons()
        self.alpha = 0
        UIView.animate(withDuration: AlertAnimationInterval, animations: {
            self.alpha = 1
        }) { (completed) in
            self.textField.becomeFirstResponder()
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
