//
//  MapView.swift
//  Macula
//
//  Created by Alex Balobanov on 10/23/17.
//  Copyright © 2017 Macula, LLC. All rights reserved.
//

import UIKit
import Mapbox

protocol MapViewDelegate: class {
	func filterAction()
	func searchAction()
	func parkingAction()
}

class MapView: UIView {

	@IBOutlet var toolbarImageView: UIImageView!
	@IBOutlet var filterButton: UIButton!
	@IBOutlet var searchButton: UIButton!
	@IBOutlet var parkingButton: UIButton!
	var mapView: MGLMapView!
	weak var delegate: MapViewDelegate?

	override func awakeFromNib() {
		// https://github.com/mapbox/mapbox-navigation-ios/issues/210
		let url = URL(string: "mapbox://styles/mapbox/streets-v10")
		mapView = MGLMapView(frame: bounds, styleURL: url)
		mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		mapView.delegate = self
		mapView.showsUserLocation = true
		mapView.userTrackingMode = .follow
		mapView.showsHeading = false
		mapView.showsUserHeadingIndicator = false
		mapView.allowsRotating = false
		insertSubview(mapView, at: 0)

		// toolbar customization
		let image = UIImage(named: "toolbar3_bg")!
		toolbarImageView.image = image.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 64, 0, 64), resizingMode: .stretch)
		toolbarImageView.addShadow()
		
		// buttons customization
		filterButton.addShadow()
		searchButton.addShadow()
		parkingButton.addShadow()
		
		// setup keyboard behavior
		enableAutomaticallyHideKeyboardOnTap()
	}

	// MARK: - Actions

	@IBAction func filterButtonPressed(_ sender: Any) {
		filterButton.isSelected = !filterButton.isSelected
		delegate?.filterAction()
	}

	@IBAction func searchButtonPressed(_ sender: Any) {
		delegate?.searchAction()
	}

	@IBAction func parkingButtonPressed(_ sender: Any) {
		if let location = mapView.userLocation {
			mapView.setCenter(location.coordinate, zoomLevel: 15, animated: true)
		}
		delegate?.parkingAction()
	}

}

extension MapView: MGLMapViewDelegate {

	// MARK: - MGLMapViewDelegate

	func mapView(_ mapView: MGLMapView, didUpdate userLocation: MGLUserLocation?) {
	}

	func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
		return nil
	}

	func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
		// Customize the user location annotation view
		if annotation is MGLUserLocation {
			guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: UserLocationAnnotationView.reuseIdentifier) as? UserLocationAnnotationView else {
				return UserLocationAnnotationView(reuseIdentifier: UserLocationAnnotationView.reuseIdentifier)
			}
			return annotationView
		}
		return nil
	}

	// Allow callout view to appear when an annotation is tapped.
	func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
		return true
	}

}
