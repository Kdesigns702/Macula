//
//  SignupViewController.swift
//  Macula
//
//  Created by Alex Balobanov on 10/17/17.
//  Copyright © 2017 Macula, LLC. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

	class func controller() -> SignupViewController {
		let storyboard = UIStoryboard(name: "Auth", bundle: nil)
		return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! SignupViewController
	}

	private var mainView: SignupView {
		return view as! SignupView
	}

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		mainView.delegate = self
    }
	
}

extension SignupViewController: SignupViewDelegate {

	// MARK: - SignupViewDelegate

	func signupAction(firstName: String, lastName: String, email: String, password: String) {
		mainView.activityIndicator(true)
		Backend.shared.signUp(firstName: firstName, lastName: lastName, email: email, password: password) { user, error in
			self.mainView.activityIndicator(false)
			if let error = error {
				UIAlertController.showError(error, controller: self)
			}
		}
	}

	func loginAction() {
		dismiss(animated: true, completion: nil)
	}

}
