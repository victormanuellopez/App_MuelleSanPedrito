//
//  ClimaData.swift
//  Clima
//
//  Created by Mac8 on 20/11/20.
//  Copyright © 2020 Arpan. All rights reserved.
//

import Foundation

struct ClimaData: Codable {
 
    let name: String
    let timezone: Int
    let main: Main
    let weather: [Weather]
    let coord: Coord
    let wind: Wind
    
    
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
    let temp_max: Double
    let temp_min: Double
}

struct Weather: Codable {
    let id: Int
    let description: String
    let icon: String
}

struct Coord: Codable {
    let lat: Double
    let lon: Double
}

struct Wind: Codable {
    let speed: Double
}

