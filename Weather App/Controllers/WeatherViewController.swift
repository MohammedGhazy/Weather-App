//
//  ViewController.swift
//  Weather App
//
//  Created by Mohamed Ghazy on 8/18/20.
//  Copyright © 2020 Mohamed Ghazy. All rights reserved.
//

import UIKit
import CoreLocation
class WeatherViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var imageCondition: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var weatherManger = WeatherManger()
    let locationManger = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManger.delegate = self
        locationManger.requestWhenInUseAuthorization()
        locationManger.requestLocation()
        
        weatherManger.delegate = self
        searchTextField.delegate = self
    }
    @IBAction func getLocationPressed(_ sender: UIButton) {
        locationManger.requestLocation()
    }
}

//Mark: - UITextFieldDelegate


extension WeatherViewController: UITextFieldDelegate{
    @IBAction func searchPressed(_ sender: UIButton) {
           searchTextField.endEditing(true)
           print(searchTextField.text!)
       }
       
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           searchTextField.endEditing(true)
           print(searchTextField.text!)
           return true
       }
       
       func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
           if searchTextField.text != ""{
               return true
           }else{
               textField.placeholder = "Type Something!"
               return false
           }
       }
       
       func textFieldDidEndEditing(_ textField: UITextField) {
           if  let city = searchTextField.text{
               weatherManger.fetchWeather(cityName: city)
           }
           searchTextField.text = ""
       }
}


//Mark: - WeatherMangerDelegate

extension WeatherViewController: WeatherMangerDelegate{
    func didUpdateWeather(_ weatherManger:WeatherManger , weather: WeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.tempratureString
            self.imageCondition.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//Mark: - CLLocationMangerDelegate

extension WeatherViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManger.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            print(lat)
            print(lon)
            
            weatherManger.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

