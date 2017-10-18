//
//  LoginViewController.swift
//  Macula
//
//  Created by Alex Balobanov on 10/17/17.
//  Copyright © 2017 Macula, LLC. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
	
	class func controller() -> LoginViewController {
		let storyboard = UIStoryboard(name: "Auth", bundle: nil)
		return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! LoginViewController
	}
	
	private var mainView: LoginView {
		return view as! LoginView
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		mainView.delegate = self
	}
	
}

extension LoginViewController: LoginViewDelegate {
	
	// MARK: - LoginViewDelegate
	
	func loginAction(email: String, password: String) {
		mainView.activityIndicator(true)
		Backend.shared.logIn(email: email, password: password) { user, error in
			print(String(describing: error))
			self.mainView.activityIndicator(false)
		}
	}
	
	func signupAction() {
		let controller = SignupViewController.controller()
		controller.modalTransitionStyle = .flipHorizontal
		present(controller, animated: true, completion: nil)
	}

}
