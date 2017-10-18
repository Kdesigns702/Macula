//
//  ViewController.swift
//  Macula
//
//  Created by Kdesigns Studios on 10/14/17.
//  Copyright © 2017 Macula, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet var userIdLabel: UILabel!

	class func controller() -> ViewController {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! ViewController
	}

    override func viewDidLoad() {
        super.viewDidLoad()
        userIdLabel.text = Backend.shared.userId
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	@IBAction func logOutButtonPressed(_ sender: Any) {
		Backend.shared.logOut()
	}

}
