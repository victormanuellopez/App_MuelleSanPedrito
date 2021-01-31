//
//  ClimaManager.swift
//  Clima
//
//  Created by Mac8 on 20/11/20.
//  Copyright © 2020 Arpan. All rights reserved.
//

import Foundation

protocol ClimaManagerDelegate {
    func actualizaClima(clima: ClimaModelo)
    
    func huboError(cualError: Error)
    
}

struct ClimaManager {
    
    var delegado: ClimaManagerDelegate?
    
    let climaURL = "https://api.openweathermap.org/data/2.5/weather?appid=bcaa596725bf26c710c8cf89b2360c4b&units=metric&lang=es"
    
    
    func fetchClima(nombreCiudad: String){
        let urlString = "\(climaURL)&q=\(nombreCiudad)"
        print(urlString)
        
        realizarSolicitud(urlString: urlString)
    }
    
    func fechtClima(lat: Double, lon: Double){
       let urlString = "\(climaURL)&lat=\(lat)&lon=\(lon)"
        
        realizarSolicitud(urlString: urlString)
    }
    
    func realizarSolicitud(urlString: String){
        //1. crear la url
        if let url = URL(string: urlString){
            
            // 2- crear obj URLSession
            let session = URLSession(configuration: .default)
                
                // 3- asignar una tarea a la session
            let tarea = session.dataTask(with: url) { (data, respuesta, error) in
                if error != nil {
                    //print(error!)
                    self.delegado?.huboError(cualError: error!)
                    return
                }
                
                if let datosSeguros = data {
                  
                    //Decodificar el obj JSON de la Api
                    if let clima = self.parseJSON(climaData: datosSeguros){
                        self.delegado?.actualizaClima(clima: clima)
                    }
                    
                }
            }
            
            // 4- empezar la tarea
            tarea.resume()
        }
    }
    
    
    func parseJSON(climaData: Data) -> ClimaModelo? {
        let decoder = JSONDecoder()
        
        do {
        let dataDecodificada = try decoder.decode(ClimaData.self, from: climaData)
            //print(dataDecodificada.name)
            
            let id = dataDecodificada.weather[0].id
            let nombre = dataDecodificada.name
            let descripcion = dataDecodificada.weather[0].description
            let temperatura = dataDecodificada.main.temp
            let icon = dataDecodificada.weather[0].icon
            let velocidad = dataDecodificada.wind.speed
            let humedad = dataDecodificada.main.humidity
            let tempmax = dataDecodificada.main.temp_max
            let tempmin = dataDecodificada.main.temp_min
            
            
            //crear obj personalizado
            //let ObjClima = ClimaModelo(condicionID: id, nombreCiudad: nombre, descripcionClima: descripcion, temperaturaCelcius: temperatura)
            
            let ObjClima = ClimaModelo(condicionID: id, nombreCiudad: nombre, descripcionClima: descripcion, temperaturaCelcius: temperatura, icono: icon, velclima: velocidad, humedad: humedad, tempmax: tempmax, tempmin: tempmin)
            
            
            return ObjClima
            
        }catch{
            //print(error)
            delegado?.huboError(cualError: error)
            return nil
        }
    }
}
