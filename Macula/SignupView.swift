//
//  SignupView.swift
//  Macula
//
//  Created by Alex Balobanov on 10/17/17.
//  Copyright © 2017 Macula, LLC. All rights reserved.
//

import UIKit
import PKHUD

protocol SignupViewDelegate: class {
	func signupAction(firstName: String, lastName: String, email: String, password: String)
	func loginAction()
}

class SignupView: UIView {

	@IBOutlet var scrollView: UIScrollView!
	@IBOutlet var firstNameTextField: UITextField!
	@IBOutlet var lastNameTextField: UITextField!
	@IBOutlet var emailTextField: UITextField!
	@IBOutlet var passwordTextField: UITextField!
	@IBOutlet var firstNameUnderlineView: UIView!
	@IBOutlet var lastNameUnderlineView: UIView!
	@IBOutlet var emailUnderlineView: UIView!
	@IBOutlet var passwordUnderlineView: UIView!
	@IBOutlet var facebookButton: UIButton!
	@IBOutlet var googleButton: UIButton!
	@IBOutlet var signupButton: UIButton!

	weak var delegate: SignupViewDelegate?
	
	override func awakeFromNib() {
		// setup keyboard behavior
		enableAutomaticallyHideKeyboardOnTap()
		scrollView.enableAutomaticallyAdjustContentInsetsForKeyboard()
		
		// custom style for buttons
		facebookButton.makeRoundButton()
		googleButton.makeRoundButton()
		
		// signup button's border
		signupButton.makeBorderedButton()
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

	private func signupAction() {
		// check first name
		guard let firstName = firstNameTextField.text, firstName.isContainText() else {
			firstNameUnderlineView.shake()
			return
		}

		// check last name
		guard let lastName = lastNameTextField.text, lastName.isContainText() else {
			lastNameUnderlineView.shake()
			return
		}

		// check email
		guard let email = emailTextField.text, email.isContainValidEmail() else {
			emailUnderlineView.shake()
			return
		}

		// check password
		guard let password = passwordTextField.text,  password.isContainValidPassword() else {
			passwordUnderlineView.shake()
			return
		}

		// hide keyboard and submit
		dismissKeyboard()
		delegate?.signupAction(firstName: firstName, lastName: lastName, email: email, password: password)
	}
	
	// MARK: - Action: return key pressed
	
	@IBAction func firstNameTextFieldReturnKeyPressed(_ sender: Any) {
		// jump to the last name field
		lastNameTextField.becomeFirstResponder()
	}

	@IBAction func lastNameTextFieldReturnKeyPressed(_ sender: Any) {
		// jump to the email field
		emailTextField.becomeFirstResponder()
	}

	@IBAction func emailTextFieldReturnKeyPressed(_ sender: Any) {
		// jump to the password field
		passwordTextField.becomeFirstResponder()
	}
	
	@IBAction func passwordTextFieldReturnKeyPressed(_ sender: Any) {
		signupAction()
	}
	
	// MARK: - Action: text changed
	
	@IBAction func firstNameTextFieldChanged(_ sender: Any) {
		firstNameUnderlineView.backgroundColor = firstNameTextField.text!.isContainText() ? Config.UI.normalUnderlineViewColor : Config.UI.lightUnderlineViewColor
	}

	@IBAction func lastNameTextFieldChanged(_ sender: Any) {
		lastNameUnderlineView.backgroundColor = lastNameTextField.text!.isContainText() ? Config.UI.normalUnderlineViewColor : Config.UI.lightUnderlineViewColor
	}

	@IBAction func emailTextFieldChanged(_ sender: Any) {
		emailUnderlineView.backgroundColor = emailTextField.text!.isContainValidEmail() ? Config.UI.normalUnderlineViewColor : Config.UI.lightUnderlineViewColor
	}

	@IBAction func passwordTextFieldChanged(_ sender: Any) {
		passwordUnderlineView.backgroundColor = passwordTextField.text!.isContainValidPassword() ? Config.UI.normalUnderlineViewColor : Config.UI.lightUnderlineViewColor
	}

	// MARK: - Action: button pressed

	@IBAction func signupButtonPressed(_ sender: Any) {
		signupAction()
	}

	@IBAction func loginButtonPressed(_ sender: Any) {
		delegate?.loginAction()
	}

}
