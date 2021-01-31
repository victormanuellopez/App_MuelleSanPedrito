//
//  ClimaModelo.swift
//  Clima
//
//  Created by Mac8 on 23/11/20.
//  Copyright © 2020 Arpan. All rights reserved.
//

import Foundation

struct ClimaModelo {
    let condicionID: Int
    let nombreCiudad: String
    let descripcionClima: String
    let temperaturaCelcius: Double
    let icono: String
    let velclima: Double
    let humedad: Int
    let tempmax: Double
    let tempmin: Double
    
    //crear propiedad computada
    var condicionClima: String {
        switch condicionID {
        case 200...232:
            return "tornado"
        case 300...321:
            return "cloud.sleet.fill"
        case 500...531:
            return "cloud.foh.fill"
        case 600...622:
            return "snow"
        case 701...781:
            return ""
        case 800:
            return "sunrise.fill"
        case 801...804:
            return "cloud.fill"
        default:
            return "sun.haze.fill"
        }
    }
    
    var temperaturaDecimal: String {
        return String(format: "%.1f", temperaturaCelcius)
    }
}
