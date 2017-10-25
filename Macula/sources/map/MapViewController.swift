//
//  ViewController.swift
//  Macula
//
//  Created by Alex Balobanov on 10/23/17.
//  Copyright © 2017 Macula, LLC. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

	private var mapView: MapView {
		return view as! MapView
	}

	class func controller() -> MapViewController {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! MapViewController
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		mapView.delegate = self
    }

}

extension MapViewController: MapViewDelegate {

	// MARK: - MapViewDelegate

	func filterAction() {
		
	}

	func searchAction() {
		UIAlertController.confirmAction("Are you sure you want to sign out?", action: "Sign Out", controller: self) {
			Backend.shared.logOut()
		}
	}

	func parkingAction() {
		
	}

}
