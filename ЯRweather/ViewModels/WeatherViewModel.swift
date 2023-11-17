//
//  WeatherViewModel.swift
//  ЯRweather
//
//  Created by Renato Ferrara on 14/11/23.
//

import Foundation
import Network

 

class WeatherViewModel: ObservableObject {
    var weatherData: WeatherData
    //to contain values of the single hour
    @Published var datiGiorno: dailyDataValues
    init() {
        self.weatherData = WeatherData()
        self.datiGiorno = dailyDataValues()
    }
  
    
    func fetch( lat: Double,  long: Double){
        print("value of lat is",  lat , "value of long is",  long)
        let latitude = lat
        let longitude = long
        guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&hourly=temperature_2m,precipitation_probability,weather_code&daily=weather_code&timezone=Europe%2FBerlin") else {
            print("Errore call api")
            return 
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                // Handle error appropriately
                print("Error fetching weather data:", error!)
                return
            }
            
            do {
                print("Decoding Data from json")
                
                let weatData = try JSONDecoder().decode(WeatherData.self, from: data)
                 DispatchQueue.main.async {
                    self?.weatherData = weatData
                     self?.StructBuilder(weatherData: weatData)
                     }

 
                }catch {
                // Handle error appropriately
                print("Error decoding weather data:", error)
            }
        }
         task.resume()
       
    }

    func StructBuilder(weatherData: WeatherData){
        var data: dailyDataValues = dailyDataValues()

        for i in 0...7 {
            let time = weatherData.hourly?.time?[i] ?? "t"
            let weatherCode = Double((weatherData.hourly?.weatherCode?[i]) ?? 9)
            let temperatura = weatherData.hourly?.temperature2m?[i] ?? 9

            
            let weather = dataWeather(time: time, temperatura: temperatura, weatherCode: weatherCode)
            data.datiTempo.append(weather)
           // print("WeatherViewModel: ")
           // print(weather)
        }
        self.datiGiorno = data
       
    }
}


