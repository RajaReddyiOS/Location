//
//  LocationHelper.swift
//  Location
//
//  Created by Raja on 20/05/18.
//  Copyright © 2018 Raja. All rights reserved.
//

import CoreLocation

class LocationHelper :NSObject, CLLocationManagerDelegate {
    public static var sharedInstance:LocationHelper?
    class func shared() -> LocationHelper {
        guard let uwShared = sharedInstance else {
            sharedInstance = LocationHelper()
            return sharedInstance!
        }
        return uwShared
    }
    
    class func destroy() {
        sharedInstance = nil
    }
    
    override init() {
        super.init()
        print("initializing helper class")
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    deinit {
        print("de- initializing helper class")
    }
    
    public var locationManager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location updates: ",locations.first)
        
        guard let coordinates = locations.first?.coordinate else {return}
        
        
        
        
        let userInfo = ["coordinates":coordinates]
        NotificationCenter.default.post(name: NSNotification.Name("location_updates"), object: nil, userInfo: userInfo ?? ["emptyValues":"Oops something went wrong"])
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            break
        case .denied, .restricted:
            print("location denied show pop up here")
        default:
            break
        }
    }
    
}
