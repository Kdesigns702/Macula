//
//  ForgotPasswordViewController.swift
//  Macula
//
//  Created by Alex Balobanov on 10/24/17.
//  Copyright © 2017 Macula, LLC. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

	class func controller() -> ForgotPasswordViewController {
		let storyboard = UIStoryboard(name: "Auth", bundle: nil)
		return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! ForgotPasswordViewController
	}

	private var mainView: ForgotPasswordView {
		return view as! ForgotPasswordView
	}

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		mainView.delegate = self
	}

}

extension ForgotPasswordViewController: ForgotPasswordViewDelegate {

	// MARK: - ForgotPasswordViewDelegate

	func resetAction(email: String) {
		UIAlertController.confirmAction("Are you sure you want to reset the password?", action: "Reset", controller: self) {
			self.mainView.activityIndicator(true)
			Backend.shared.resetPassword(with: email) { error in
				self.mainView.activityIndicator(false)
				if let error = error {
					UIAlertController.showError(error, controller: self)
				}
			}
		}
	}

	func loginAction() {
		dismiss(animated: true, completion: nil)
	}

}
