//
//  ViewController.swift
//

import UIKit

class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        testStuff()
    }

    private func testStuff() {

    }

    @IBAction func alertTapped(_ sender: AnyObject) {
        let alert = Alert.createAlertFor(viewController: self, title: "Test Alert", message: "This is a test alert with a message that runs two lines.")
        alert.addButtonWith("No") {
            print("Alert - No Tapped")
        }
        alert.addButtonWith("Yes") {
            print("Alert - Yes Tapped")
        }
        alert.showAlert()
    }

    @IBAction func textAlertTapped(_ sender: AnyObject) {
        let textAlert = TextAlert.createAlertFor(viewController: self, title: "Test Text Alert", placeholder: "Type something")
        textAlert.addButtonWith("OK") {
            if let text = textAlert.textField.text {
                print("Text Alert - \(text)")
            }
        }
        textAlert.showAlert()
    }

}

