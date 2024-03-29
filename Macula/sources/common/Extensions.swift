//
//  Extensions.swift
//  Macula
//
//  Created by Alex Balobanov on 10/17/17.
//  Copyright © 2017 Macula, LLC. All rights reserved.
//

import UIKit

extension UIView {

	func shake() {
		let shake = CABasicAnimation(keyPath: "position")
		shake.duration = 0.1
		shake.repeatCount = 2
		shake.autoreverses = true
		shake.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4, y: self.center.y))
		shake.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4, y: self.center.y))
		self.layer.add(shake, forKey: "shake")
	}

	func addShadow() {
		// shadow
		layer.shadowColor = Config.UI.shadowColor.cgColor
		layer.masksToBounds = false
		layer.shadowOffset = CGSize(width: 0, height: 3)
		layer.shadowRadius = 6
		layer.shadowOpacity = 1
	}

}

extension UIAlertController {

	class func showError(_ error: Error, controller: UIViewController, completion: (() -> Void)? = nil) {
		let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
		alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { action -> Void in completion?() })
		controller.present(alert, animated: true, completion: nil)
	}

	class func confirmAction(_ message: String, action: String, controller: UIViewController, confirm: @escaping () -> Void) {
		let alert: UIAlertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: action, style: .default) { action -> Void in confirm() })
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
		controller.present(alert, animated: true, completion: nil)
	}

}

extension UIButton {

	func makeRoundButton() {
		// round corners
		layer.cornerRadius = bounds.height / 2
		// shadow
		addShadow()
	}

	func makeBorderedButton() {
		layer.borderColor = Config.UI.buttonBorderColor.cgColor
		layer.borderWidth = 1
	}

}

extension String {
	
	func isContainValidEmail() -> Bool {
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
		return NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: self)
	}
	
	func isContainValidPassword() -> Bool {
		// TODO: add rules for passwords
		let trimmedText = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		return trimmedText.characters.count >= 6
	}
	
	func isContainText() -> Bool {
		return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).characters.count > 0
	}
	
}

extension UIColor {
	
	static func RGB(_ rgbValue: UInt) -> UIColor {
		return UIColor(
			red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
			green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
			blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
			alpha: CGFloat(1.0)
		)
	}
	
}

extension UIScrollView {

	func enableAutomaticallyAdjustContentInsetsForKeyboard() {
		// keyboard show/hide events
		let nc = NotificationCenter.default
		nc.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
		nc.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
	}
	
	func disableAutomaticallyAdjustContentInsetsForKeyboard() {
		// remove keyboard observers
		let nc = NotificationCenter.default
		nc.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
		nc.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
	}
	
	@objc func keyboardWillShow(notification: NSNotification) {
		// set bottom content inset for keyboard
		if let userInfo = notification.userInfo, let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
			contentInset.bottom = keyboardSize.cgRectValue.size.height
		}
	}
	
	@objc func keyboardWillHide(notification: NSNotification) {
		// reset bottom content inset
		contentInset.bottom = 0
	}

}

extension UIView {
	
	func firstScrollView() -> UIScrollView? {
		// find first scroll view in the view hierarchy
		return subviews.first(where: { $0 is UIScrollView }) as? UIScrollView
	}
	
	func enableAutomaticallyHideKeyboardOnTap() {
		// hide keyboard on tap
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		addGestureRecognizer(tap)
	}
	
	@objc func dismissKeyboard() {
		endEditing(true)
	}

}
