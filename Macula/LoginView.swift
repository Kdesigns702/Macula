//
//  LoginView.swift
//  Macula
//
//  Created by Alex Balobanov on 10/17/17.
//  Copyright © 2017 Macula, LLC. All rights reserved.
//

import UIKit

class LoginView: UIView {
	@IBOutlet var scrollView: UIScrollView!
	@IBOutlet var facebookButton: UIButton!
	@IBOutlet var googleButton: UIButton!
	@IBOutlet var loginButton: UIButton!
	@IBOutlet var emailTextField: UITextField!
	@IBOutlet var passwordTextField: UITextField!
	
	override func awakeFromNib() {
		// setup keyboard behavior
		enableAutomaticallyHideKeyboardOnTap()
		scrollView.enableAutomaticallyAdjustContentInsetsForKeyboard()

		// custom style for buttons
		for button in [ facebookButton!, googleButton! ] {
			// round corners
			button.layer.cornerRadius = button.bounds.height / 2
			// shadow
			button.layer.shadowColor = UIColor.black.withAlphaComponent(0.17).cgColor
			button.layer.masksToBounds = false
			button.layer.shadowOffset = CGSize(width: 0, height: 3)
			button.layer.shadowRadius = 6
			button.layer.shadowOpacity = 1
		}
		
		// login button's border
		loginButton.layer.borderColor = UIColor.RGB(0x0FA0C1).cgColor
		loginButton.layer.borderWidth = 1
	}
	
	deinit {
		scrollView.disableAutomaticallyAdjustContentInsetsForKeyboard()
	}
	
	// MARK: - Actions
	
	@IBAction func emailTextFieldReturnKeyPressed(_ sender: Any) {
		// jump to the next field
		passwordTextField.becomeFirstResponder()
	}

	@IBAction func passwordTextFieldReturnKeyPressed(_ sender: Any) {
		// hide keyboard and submit
		dismissKeyboard()
	}

}
