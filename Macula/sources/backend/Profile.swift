//
//  Profile.swift
//  Macula
//
//  Created by Alex Balobanov on 10/23/17.
//  Copyright © 2017 Macula, LLC. All rights reserved.
//

import Foundation
import Firebase

class Profile: DatabaseObject {
	
	struct Key {
		static let userId = "uid"				// user id
		static let first = "first"				// first name
		static let last = "last"				// last name
		static let email = "email"				// email
	}
	
	override class open var basePath: String {
		return "profile"
	}
	
	override open var data: [String : Any] {
		return [
			Key.userId: userId,
			Key.first: firstName,
			Key.last: lastName,
			Key.email: email
		]
	}
	
	private(set) var userId: String
	var firstName: String
	var lastName: String
	var email: String
	
	init(userId: String, first firstName: String, last lastName: String, email: String) {
		self.userId = userId
		self.firstName = firstName
		self.lastName = lastName
		self.email = email
		super.init()
	}
	
	required init?(snapshot: DataSnapshot) {
		guard let data = snapshot.value as? [String: Any],
			let userId = data[Key.userId] as? String,
			let firstName = data[Key.first] as? String,
			let lastName = data[Key.last] as? String,
			let email = data[Key.email] as? String
			else {
				return nil
		}
		self.userId = userId
		self.firstName = firstName
		self.lastName = lastName
		self.email = email
		super.init(snapshot: snapshot)
	}

}
