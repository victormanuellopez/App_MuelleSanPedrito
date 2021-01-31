//
//  PeliculasViewController.swift
//  EsqueletonProject
//
//  Created by marco alonso on 13/01/21.
//

import UIKit
import CoreLocation

class ClimaViewController: UIViewController {
    
    var locationManager = CLLocationManager()
    var climaManager = ClimaManager()
    
    
    @IBOutlet weak var iconoclima: UIImageView!
    @IBOutlet weak var buscarButton: UIButton!
    
    @IBOutlet weak var buscarCiudad: UITextField!
    
    @IBOutlet weak var temperatura: UILabel!
    
    @IBOutlet weak var Ciudad: UILabel!
    
    @IBOutlet weak var Viento: UILabel!
    
    
    @IBOutlet weak var Humedad: UILabel!
    
    
    @IBOutlet weak var temMax: UILabel!
    
    @IBOutlet weak var temMin: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
               locationManager.requestWhenInUseAuthorization()
               locationManager.requestLocation() //obtener la ubicacion
               
               climaManager.delegado = self
               
               buscarCiudad.delegate = self
    }
    
    
    @IBAction func BuscarCuidad(_ sender: UIButton) {
        
        print(buscarCiudad.text!)
        Ciudad.text = buscarCiudad.text
        climaManager.fetchClima(nombreCiudad: buscarCiudad.text!)
        
    }
    
    
    @IBAction func Ubicacion(_ sender: UIBarButtonItem) {
        
        locationManager.requestLocation()
    }
}

// MARK: - Hacer la peticion a la API
extension ClimaViewController: ClimaManagerDelegate {
 
    
    func huboError(cualError: Error) {
        
        DispatchQueue.main.async {
            self.Ciudad.text = cualError.localizedDescription
            
        }
        print(cualError.localizedDescription)
        
    }
    
    func actualizaClima(clima: ClimaModelo) {
        
        DispatchQueue.main.async {
            //self.liconoc.image = UIImage(named: clima.icono)
            self.temperatura.text = clima.temperaturaDecimal
            self.Ciudad.text = "En \(clima.nombreCiudad), hay \(clima.descripcionClima)"
            self.iconoclima.image = UIImage(named: clima.condicionClima)
            self.Viento.text = "velocidad de viento: \(String(clima.velclima)) Km/h"
            self.Humedad.text = "humedad: \(String(clima.humedad)) % "
            self.temMax.text = "temperatura maxima: \(String(clima.tempmax)) °C"
            self.temMin.text = "temperatura minima: \(String(clima.tempmin)) °C"
            
        }
        
        print(clima.temperaturaCelcius)
        print(clima.condicionID)
        
    }
}

//MARK: - obtener la ubicacion del usuario
extension ClimaViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("ubicacion obtenida")
        if  let ubicacion = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = ubicacion.coordinate.latitude
            let lon = ubicacion.coordinate.longitude
            print("lat: \(lat), lon: \(lon)")
            
            climaManager.fechtClima(lat: lat, lon: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}


//MARK: - Delegado del TextField
extension ClimaViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField){
        buscarCiudad.text = ""
    }
    
    //activar el codigo del boton buscar en el teclado
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //print(buscarTexto.text!)
        climaManager.fetchClima(nombreCiudad: buscarCiudad.text!)
        return true
    }
    
    //validar si el usuario escribio algo en el textfield
    func textfieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if buscarCiudad.text != "" {
            return true
        } else {
            buscarCiudad.placeholder = "escribe una ciudad"
            print("Por Favor escribe algo...")
            return false
        }
    }
    
}
