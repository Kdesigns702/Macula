//
//  UserLocationAnnotationView.swift
//  Macula
//
//  Created by Alex Balobanov on 10/23/17.
//  Copyright © 2017 Macula, LLC. All rights reserved.
//

import UIKit
import Mapbox

// https://github.com/mapbox/mapbox-gl-native/issues/5489

class UserLocationAnnotationView: MGLUserLocationAnnotationView {
	
	static let reuseIdentifier = "UserLocationAnnotationViewReuseIdentifier"
	private let image = UIImage(named: "car-gps-icon")!
	
	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		
		// force the annotation view to maintain a constant size when the map is tilted.
		scalesWithViewingDistance = false
		layer.contentsScale = UIScreen.main.scale
		layer.contentsGravity = kCAGravityCenter
		
		// use a custom image for user location
		layer.contents = image.cgImage
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError()
	}

}
