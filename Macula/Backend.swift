//
//  Backend.swift
//  Macula
//
//  Created by Alex Balobanov on 10/18/17.
//  Copyright © 2017 Macula, LLC. All rights reserved.
//

import UIKit
import Firebase

extension Notification.Name {
	static let backendUserHasSignedIn = Notification.Name("backendUserHasSignedIn")
	static let backendUserHasSignedOut = Notification.Name("backendUserHasSignedOut")
}

class Backend: NSObject {

	static let shared = Backend()

	// firebase user
	private var user: User?

	// firebase user id
	var userId: String {
		guard let user = user else {
			fatalError("You can't use this method before authentication.")
		}
		return user.uid
	}

	func configure() {
		FirebaseApp.configure()
		let _ = Auth.auth().addStateDidChangeListener() { [weak self] (auth, user) in
			if let strongSelf = self {
				let nc = NotificationCenter.default
				if let user = user {
					strongSelf.user = user
					nc.post(name: .backendUserHasSignedIn, object: user)
				}
				else {
					strongSelf.user = nil
					nc.post(name: .backendUserHasSignedOut, object: nil)
				}
			}
		}
	}

	func logIn(email: String, password: String, completion: @escaping (_ user: User?, _ error: Error?) -> Void) {
		Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
			completion(user, error)
		}
	}
	
	func logOut() {
		_ = try? Auth.auth().signOut()
	}

	func signUp(firstName: String, lastName: String, email: String, password: String, completion: @escaping (_ user: User?, _ error: Error?) -> Void) {
		// create a user
		Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
			if let user = user {
				// update a profile
				let changeRequest = user.createProfileChangeRequest()
				changeRequest.displayName = "\(firstName) \(lastName)"
				changeRequest.commitChanges { (error) in
					completion(user, error)
				}
			}
			else {
				completion(user, error)
			}
		}
	}

}
