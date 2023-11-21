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
    @Published var citta: String
    //to contain values of the single hour
     @Published var datiGiorno: dailyDataValues
    
    @Published var currentWeather: dataWeather
    
    init() {
        self.weatherData = WeatherData()
        self.datiGiorno = dailyDataValues()
        self.citta = ""
        
        self.currentWeather = dataWeather()
     }
  
    
    func fetch( lat: Double,  long: Double){
        let latitude = lat
        let longitude = long
       
        
        
        guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&hourly=temperature_2m,precipitation_probability,weather_code&daily=weather_code&timezone=Europe%2FBerlin")
        else {
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
        print(weatherData)
         task.resume()
       
    }

    func StructBuilder(weatherData: WeatherData){
        var data: dailyDataValues = dailyDataValues()
        let time = weatherData.hourly?.time?[0] ?? "t"
        print(weatherData)
        var currentTime: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH"
            return dateFormatter.string(from: Date.now)
        }
        var counter: Int = 0
         for i in 0...24 {
            let time = weatherData.hourly?.time?[i] ?? "t"
            if(time.prefix(13) == currentTime.prefix(13)){
                counter = i
                print(counter)
                break
            }
        }
               
            
                for j in (0+counter)...(24+counter){
                    print(0+counter)
                    print(24+counter)
                    let time = weatherData.hourly?.time?[j] ?? "t"

                    let weatherCode = Double((weatherData.hourly?.weatherCode?[j]) ?? 9)
                    let temperatura = weatherData.hourly?.temperature2m?[j] ?? 9
                    let code = getWeatherCodeDescription(code: weatherCode)
                    let prec = weatherData.hourly?.precipitationProbability?[j] ?? 9
                    
                    let weather = dataWeather(time: time, temperatura: temperatura, weatherCode: code, precipitation: prec)
                    data.datiTempo.append(weather)
                    // print("WeatherViewModel: ")
                    // print(weather)
                    
                    
                    
                    print(time.prefix(13))
                    print(currentTime.prefix(13))
                    if(time.prefix(13) == currentTime.prefix(13) ) {
                        self.currentWeather = weather
                        print("CURRENT WEATHER:")
                        print(weather)
                    }
                }
    
               print(data)
        self.datiGiorno = data
       
    }
    
    
}


