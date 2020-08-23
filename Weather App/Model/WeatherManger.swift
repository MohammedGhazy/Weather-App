//
//  WeatherManger.swift
//  Weather App
//
//  Created by Mohamed Ghazy on 8/21/20.
//  Copyright © 2020 Mohamed Ghazy. All rights reserved.
//

import Foundation
import CoreLocation
protocol WeatherMangerDelegate {
    func didUpdateWeather(_ weatherManger:WeatherManger , weather: WeatherModel)
    func didFailWithError(error: Error)
}


class WeatherManger{
    let baseWeatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=b4fe9ada9bc53dbea2421db0c082153a&units=metric"
    
    var delegate: WeatherMangerDelegate?
    
    func fetchWeather(cityName:String){
        let urlString = "\(baseWeatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude:CLLocationDegrees,longitude:CLLocationDegrees){
        let urlString = "\(baseWeatherURL)&lat=\(latitude)$lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString:String){
        // 1- create url
        if let url = URL(string: urlString){
        // 2- create urlSession
            let session = URLSession(configuration: .default)
        // 3- give urlSession a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
        // 4- start the task
            task.resume()
        }
        
    }
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
       let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temprature: temp)
            return weather
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
