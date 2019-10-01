//
//  ControllerAvecCarte.swift
//  Les Calanques
//
//  Created by Adib Lgs on 2019-09-15.
//  Copyright © 2019 Adib Lgs. All rights reserved.
//

import UIKit
import MapKit

class ControllerAvecCarte: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var userPosition: CLLocation?
    var calanques: [Calanque] = CalanqueCollection().all()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsUserLocation = true
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        addAnnotation()
        NotificationCenter.default.addObserver(self, selector: #selector(notifDetail), name: Notification.Name("detail"), object: nil)
        if calanques.count > 5 {
            let premiere = calanques[5].coordonnee
            setupMap(coordonnees: premiere)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            if let maPosition = locations.last {
                userPosition = maPosition
            }
        }
    }
    
    func setupMap(coordonnees: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.35, longitudeDelta: 0.35)
        let region = MKCoordinateRegion(center: coordonnees, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    @objc func notifDetail(notification: Notification) {
        if let calanque = notification.object as? Calanque {
            print("J'ai une calanque")
            toDetail(calanque: calanque)
        }
    }
    
    func toDetail(calanque: Calanque) {
        performSegue(withIdentifier:"Detail", sender: calanque)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            if let controller = segue.destination as? DetailController {
                controller.calanqueRecue = sender as? Calanque
            }
        }
    }
    func addAnnotation() {
        for calanque in calanques {
           
            
            //Annotation de base
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = calanque.coordonnee
//            annotation.title = calanque.nom
//            mapView.addAnnotation(annotation)
            
            //Annotation Custom
            
            let annotation = MonAnnotation(calanque)
            mapView.addAnnotation(annotation)
        }
    }
   
    func mapView(_mapView: MKMapView, viewFor annotation: MKAnnotation) ->
        MKAnnotationView? {
            let reuseIdentifier = "reuseID"
            //Verifier que ce ne soit pas position User
            if annotation.isKind(of: MKUserLocation.self) {
                return nil
            }
            if let anno = annotation as? MonAnnotation {
                var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
                if annotationView == nil {
                    //Override
                    //annotationView = MonAnnotationView(annotation: anno,
                      //          reuseIdentifier: reuseIdentifier)
                    
                    annotationView = MonAnnotationView(controller: self, annotation: anno, reuseIdentifier: reuseIdentifier)
                    
                   // annotationView = MKAnnotationView(annotation: anno, reuseIdentifier: reuseIdentifier)
                   // annotationView?.image = UIImage(named: "placeholder")
                    //annotationView?.canShowCallout = true
                    return annotationView
                } else {
                    return annotationView
                }
            }
            return nil
    }
    
    
    @IBAction func getPosition(_ sender: Any) {
        if userPosition != nil {
            setupMap(coordonnees: userPosition!.coordinate)
        }
    }
    
    @IBAction func segmentedChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0 : mapView.mapType = MKMapType.standard
        case 1 : mapView.mapType = .satellite
        case 2 : mapView.mapType = .hybrid
        default: break
        }
    }
    
    
    
}
