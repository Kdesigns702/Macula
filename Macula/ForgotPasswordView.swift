//
//  ForgotPasswordView.swift
//  Macula
//
//  Created by Alex Balobanov on 10/24/17.
//  Copyright © 2017 Macula, LLC. All rights reserved.
//

import UIKit
import PKHUD

protocol ForgotPasswordViewDelegate: class {
	func resetAction(email: String)
	func loginAction()
}

class ForgotPasswordView: UIView {
	@IBOutlet var scrollView: UIScrollView!
	@IBOutlet var emailTextField: UITextField!
	@IBOutlet var emailUnderlineView: UIView!
	@IBOutlet var resetButton: UIButton!
	@IBOutlet var facebookButton: UIButton!
	@IBOutlet var googleButton: UIButton!

	weak var delegate: ForgotPasswordViewDelegate?

	override func awakeFromNib() {
		// setup keyboard behavior
		enableAutomaticallyHideKeyboardOnTap()
		scrollView.enableAutomaticallyAdjustContentInsetsForKeyboard()
		
		// custom style for buttons
		facebookButton.makeRoundButton()
		googleButton.makeRoundButton()
		
		// reset button's border
		resetButton.makeBorderedButton()
	}

	deinit {
		scrollView.disableAutomaticallyAdjustContentInsetsForKeyboard()
	}

	func activityIndicator(_ show: Bool) {
		if show {
			HUD.show(.systemActivity)
		}
		else {
			HUD.hide()
		}
	}

	private func resetAction() {
		// check email
		guard let email = emailTextField.text, email.isContainValidEmail() else {
			emailUnderlineView.shake()
			return
		}

		// hide keyboard and submit
		dismissKeyboard()
		delegate?.resetAction(email: email)
	}

	// MARK: - Action: return key pressed

	@IBAction func emailTextFieldReturnKeyPressed(_ sender: Any) {
		resetAction()
	}

	// MARK: - Action: text changed

	@IBAction func emailTextFieldChanged(_ sender: Any) {
		emailUnderlineView.backgroundColor = emailTextField.text!.isContainValidEmail() ? Config.UI.normalUnderlineViewColor : Config.UI.lightUnderlineViewColor
	}

	// MARK: - Action: button pressed

	@IBAction func resetButtonPressed(_ sender: Any) {
		resetAction()
	}

	@IBAction func loginButtonPressed(_ sender: Any) {
		delegate?.loginAction()
	}

}
