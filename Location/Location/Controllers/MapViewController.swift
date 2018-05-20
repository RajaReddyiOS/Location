//
//  ViewController.swift
//  Location
//
//  Created by Raja on 20/05/18.
//  Copyright © 2018 Raja. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    private var center:CLLocationCoordinate2D?
    private var isLocationUpdated = false

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _=LocationHelper.shared()
        NotificationCenter.default.addObserver(self, selector: #selector(self.locationUpdates(_:)), name: NSNotification.Name(rawValue: "location_updates"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("location_updates"), object: nil)
        LocationHelper.destroy()
    }

    @objc fileprivate func locationUpdates(_ notification:NSNotification) {
        guard let userInfo = notification.userInfo as? [String: Any] else {return}
        guard let center = userInfo["coordinates"] as? CLLocationCoordinate2D else {return}
        self.center = center
        if !isLocationUpdated {
            isLocationUpdated = true
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    @IBAction func locateeBtnHandler(_ sender: Any) {
        if self.center != nil {
            let region = MKCoordinateRegion(center: center!, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapView.setRegion(region, animated: true)
        }
    }
    
}

