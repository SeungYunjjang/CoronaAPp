//
//  SecondViewController.swift
//  SideMenu
//
//  Created by 승윤 on 06/04/2019.
//  Copyright © 2019 김승윤. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ClinicViewController: BaseViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 1000
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
        getJsonData()
    }
    
    @IBAction func currentLocationBtn(_ sender: UIButton) {
        if let coor = mapView.userLocation.location?.coordinate {
            mapView.setCenter(coor, animated: true)
        }
    }
    
    private func getJsonData() {
        let decoder = JSONDecoder()
        
        guard let path = Bundle.main.path(forResource: "Clinic", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
            let clinics = try? decoder.decode([Clinic].self, from: data)
            else { return }
        
        clinics.map { ClinicPresentModel.init($0) }
            .map { [weak self] model in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    let annotations = MKPointAnnotation()
                    
                    annotations.title = model.clinicName
                    annotations.subtitle = "\(model.address)\n\(model.phoneNumber)"
                    annotations.coordinate = CLLocationCoordinate2D(latitude:
                        model.lattitude, longitude: model.longtitude)
                    
                    self.mapView.addAnnotation(annotations)
                }
        }
        
    }
    
}//class

extension ClinicViewController: MKMapViewDelegate {
    
}

extension ClinicViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let lat = location.coordinate.latitude
        let long = location.coordinate.longitude
        
        let span = MKCoordinateSpan(latitudeDelta: 0.050, longitudeDelta: 0.050)
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: long), span: span)
        mapView.setRegion(region, animated: true)
        
    }
}



