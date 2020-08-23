//
//  WeatherData.swift
//  Weather App
//
//  Created by Mohamed Ghazy on 8/23/20.
//  Copyright © 2020 Mohamed Ghazy. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather :Codable {
    let description: String
    let id: Int
}
