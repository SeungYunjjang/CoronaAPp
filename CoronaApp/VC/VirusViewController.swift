//
//  FirstViewController.swift
//  SideMenu
//
//  Created by 승윤 on 06/04/2019.
//  Copyright © 2019 김승윤. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class VirusViewController: BaseViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    private let locationManager = CLLocationManager()
    private var annotations: [MKAnnotation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setlocationManager()
        getJsonData()
        
        searchLocal(to: "서")
    }
    
    @IBAction func currentLocationBtn(_ sender: UIButton) {
        if let coor = mapView.userLocation.location?.coordinate {
            mapView.setCenter(coor, animated: true)
        }
    }
    
    private func searchLocal(to local: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = local
        searchRequest.region = mapView.region
        
        MKLocalSearch(request: searchRequest).start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }

            for item in response.mapItems {
                print(item.phoneNumber ?? "No phone number.")
            }
        }
    }
    
//    func checkLocationAuthorization() {
//        switch CLLocationManager.authorizationStatus() {
//        case .authorizedWhenInUse:
//            mapView.showsUserLocation = true
//        case .denied: // Show alert telling users how to turn on permissions
//            break
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//            mapView.showsUserLocation = true
//        case .restricted: // Show an alert letting them know what’s up
//            break
//        case .authorizedAlways:
//            break
//        }
//    }
    
    private func setlocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 1000
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
    }
    
    private func getJsonData() {
        let decoder = JSONDecoder()
        
        guard let path = Bundle.main.path(forResource: "Virus", ofType: "json"),
        let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
        let virus = try? decoder.decode([Virus].self, from: data)
        else {
            return }
        
        self.annotations = virus.map { VirusPresentModel.init($0) }
            .map { model -> MKPointAnnotation in
                let annotation = MKPointAnnotation()
                annotation.title = model.title
                annotation.subtitle = model.content
                annotation.coordinate = CLLocationCoordinate2D(latitude: model.lattitude, longitude: model.longtitude)
                return annotation
        }
        
        DispatchQueue.main.async {
            self.mapView.addAnnotations(self.annotations)
        }
    }
    
    
    
}//class

extension VirusViewController: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        let index = annotations.firstIndex{ $0 === annotation }.hashValue
        // model[index].type == 녹색 / 노란
        // view 변환
//    }
    
}

extension VirusViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let lat = location.coordinate.latitude
        let long = location.coordinate.longitude
        
        let span = MKCoordinateSpan(latitudeDelta: 0.050, longitudeDelta: 0.050)
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: long), span: span)
        mapView.setRegion(region, animated: true)
        
    }
}


