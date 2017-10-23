//
//  LoginView.swift
//  Macula
//
//  Created by Alex Balobanov on 10/17/17.
//  Copyright © 2017 Macula, LLC. All rights reserved.
//

import UIKit
import PKHUD

protocol LoginViewDelegate: class {
	func loginAction(email: String, password: String)
	func signupAction()
}

class LoginView: UIView {
	@IBOutlet var scrollView: UIScrollView!
	@IBOutlet var emailTextField: UITextField!
	@IBOutlet var passwordTextField: UITextField!
	@IBOutlet var emailUnderlineView: UIView!
	@IBOutlet var passwordUnderlineView: UIView!
	@IBOutlet var loginButton: UIButton!
	@IBOutlet var facebookButton: UIButton!
	@IBOutlet var googleButton: UIButton!

	weak var delegate: LoginViewDelegate?

	override func awakeFromNib() {
		// setup keyboard behavior
		enableAutomaticallyHideKeyboardOnTap()
		scrollView.enableAutomaticallyAdjustContentInsetsForKeyboard()

		// custom style for buttons
		facebookButton.makeRoundButton()
		googleButton.makeRoundButton()
		
		// login button's border
		loginButton.makeBorderedButton()
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

	private func loginAction() {
		// check email
		guard let email = emailTextField.text, email.isContainValidEmail() else {
			emailUnderlineView.shake()
			return
		}

		// check password
		guard let password = passwordTextField.text,  password.isContainText() else {
			passwordUnderlineView.shake()
			return
		}

		// hide keyboard and submit
		dismissKeyboard()
		delegate?.loginAction(email: email, password: password)
	}

	// MARK: - Action: return key pressed

	@IBAction func emailTextFieldReturnKeyPressed(_ sender: Any) {
		// jump to the next field
		passwordTextField.becomeFirstResponder()
	}
	
	@IBAction func passwordTextFieldReturnKeyPressed(_ sender: Any) {
		loginAction()
	}

	// MARK: - Action: text changed

	@IBAction func passwordTextFieldChanged(_ sender: Any) {
		passwordUnderlineView.backgroundColor = passwordTextField.text!.isContainText() ? Config.UI.normalUnderlineViewColor : Config.UI.lightUnderlineViewColor
	}
	
	@IBAction func emailTextFieldChanged(_ sender: Any) {
		emailUnderlineView.backgroundColor = emailTextField.text!.isContainValidEmail() ? Config.UI.normalUnderlineViewColor : Config.UI.lightUnderlineViewColor
	}

	// MARK: - Action: button pressed

	@IBAction func loginButtonPressed(_ sender: Any) {
		loginAction()
	}

	@IBAction func signupButtonPressed(_ sender: Any) {
		delegate?.signupAction()
	}

}
