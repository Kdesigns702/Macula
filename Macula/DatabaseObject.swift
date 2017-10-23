//
//  DatabaseObject.swift
//  Macula
//
//  Created by Alex Balobanov on 10/23/17.
//  Copyright © 2017 Macula, LLC. All rights reserved.
//

import Foundation
import Firebase

class DatabaseObject {

	class open var basePath: String {
		return ""
	}
	
	open var data: [String: Any] {
		return [:]
	}

	final let ref: DatabaseReference

	final public var key: String {
		return ref.key
	}

	init() {
		ref = Database.database().reference(withPath: type(of: self).basePath).childByAutoId()
	}

	init(key: String) {
		ref = Database.database().reference(withPath: type(of: self).basePath).child(key)
	}

	required init?(snapshot: DataSnapshot) {
		ref = snapshot.ref
	}

	func set(data: [String: Any]) {
	}

	final class func read(from ref: DatabaseQuery, with completion: @escaping (Error?, DataSnapshot?) -> Void) {
		ref.observeSingleEvent(of: .value, with: { snapshot in
			completion(nil, snapshot)
		}) { error in
			completion(error, nil)
		}
	}

	final func update(with completion: @escaping (Error?) -> Void) {
		ref.updateChildValues(data) { error, ref in
			completion(error)
		}
	}

	final func delete(completion: @escaping (Error?) -> Void) {
		ref.removeValue() { error, ref in
			completion(error)
		}
	}

}
