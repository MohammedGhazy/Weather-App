//
//  WeatherManger.swift
//  Weather App
//
//  Created by Mohamed Ghazy on 8/21/20.
//  Copyright © 2020 Mohamed Ghazy. All rights reserved.
//

import Foundation

class WeatherManger{
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=b4fe9ada9bc53dbea2421db0c082153a&units=metric"
    
    func fetchWeather(cityName:String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString:String){
        // 1- create url
        if let url = URL(string: urlString){
        // 2- create urlSession
        let session = URLSession(configuration: .default)
        // 3- give urlSession a task
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
        // 4- start the task
            task.resume()
        }
        
    }
    func handle(data:Data?,response:URLResponse?,error:Error?){
        if error != nil{
        print(error!)
        return
        }
         if let safeData = data{
         let dataString = String(data: safeData, encoding: .utf8)
         print(dataString!)
        }
    }
}
