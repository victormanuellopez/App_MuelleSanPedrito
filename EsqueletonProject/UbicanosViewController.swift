//
//  UbicanosViewController.swift
//  EsqueletonProject
//
//  Created by marco alonso on 13/01/21.
//

import UIKit
import MapKit

class UbicanosViewController: UIViewController {
    
    var manager = CLLocationManager()
    var latitud : CLLocationDegrees!
    var longitud : CLLocationDegrees!
    
    @IBOutlet weak var Mapa: MKMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }
    

    
    
    @IBAction func getLocation(_ sender: UIBarButtonItem) {
       
        
        let alert = UIAlertController(title: "Ubicacion", message: "Las coordenas de tu ubicacion son :\(latitud), \(longitud)", preferredStyle: .alert)
        
        let actionAceptar = UIAlertAction(title: "Aceptar", style: .default){ (_) in
            self.dismiss(animated: true, completion: nil)
        }
        
        let actionvermas = UIAlertAction(title: "Ver mas", style: .default){ (_) in
        
            let localizacion = CLLocationCoordinate2DMake(self.latitud, self.longitud)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            
            let region = MKCoordinateRegion(center: localizacion, span: span)
            
            self.Mapa.setRegion(region, animated: true)
            
            self.Mapa.showsUserLocation = true
        }
        
        alert.addAction(actionAceptar)
        alert.addAction(actionvermas)
        
        present(alert, animated: true, completion: nil)
    }
    
}

extension UbicanosViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            self.latitud = location.coordinate.latitude
            self.longitud = location.coordinate.longitude
        }
    }
    
}
