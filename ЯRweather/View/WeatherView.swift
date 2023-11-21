//
//  ContentView.swift
//  ЯRweather
//
//  Created by Renato Ferrara on 14/11/23.
//
import SwiftUI
import CoreLocation
import CoreLocationUI
struct WeatherView: View {
    @AppStorage("FirstStart") var alertShouldBeShown = true
    @State var city: String = ""
    @State var currentWeather: dataWeather = dataWeather()
    @State var tempNow: String = ""
 
    
    @StateObject var locationManager = LocationManager()
    
    
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        ZStack{
            Color.blue.ignoresSafeArea()
                .opacity(0.6)
            
            
            VStack {
                LocationButton {
                    locationManager.requestLocation()
                    fetchWeatherData()
                }
                /*.alert(isPresented: $alertShouldBeShown, content: {
                    
                    Alert(title: Text("Headline"),
                          message: Text("Placeholder"),
                          dismissButton: Alert.Button.default(
                            Text("Accept"), action: {
                                UserDefaults.standard.set(true, forKey: "FirstStart")
                            }
                          )
                    )
                })*/
                .foregroundStyle(Color.yellow)
                .frame(height: 44).shadow(color: .white, radius: 4)
                .padding()
                VStack{
                    
                    Text(city)
                    Text(String(tempNow)).font(.largeTitle)
                    Image(String(currentWeather.weatherCode)).font(.subheadline)
                    HStack{
                        Text("Precipitation:")
                        Text(String(currentWeather.precipitationProb) + "%").font(.subheadline)
 
                        
                    }
 
                } .foregroundColor(.white)

                

                
                ZStack{
                    Color.blue.clipShape( RoundedRectangle(cornerRadius: 16))
                        .frame(width:  360, height: 110)
                    ScrollView(.horizontal) {
                        LazyHStack{
                            ForEach(viewModel.datiGiorno.datiTempo, id: \.id) { day in
                                VStack {
                                    
                                    Text((day.time.prefix(13)).components(separatedBy: "T")[1])
                                    Image(systemName: day.weatherCode)
                                    Text(formatTemp(temp: day.temperatura))
                                } .foregroundColor(.white)
                                    .padding()
                                
                            }
                        }
                        .padding()
                        
                    }  .frame(width:  360, height: 110)

                }
            }
        }
    }
    func fetchWeatherData() {
      
        if let location = locationManager.location {
            
            
            self.currentWeather = viewModel.currentWeather
            let measurement = Measurement(value: currentWeather.temperatura, unit: UnitTemperature.celsius)

            let measurementFormatter = MeasurementFormatter()
            measurementFormatter.unitStyle = .short
            measurementFormatter.numberFormatter.maximumFractionDigits = 0
            measurementFormatter.unitOptions = .temperatureWithoutUnit

            self.tempNow = measurementFormatter.string(from: measurement)
            
            
            
            
            
            
            
            viewModel.fetch(lat: location.latitude, long: location.longitude)
            locationManager.getLocationCity(lat: locationManager.location!.latitude, long: locationManager.location!.longitude) { cityName in
                    self.city = cityName
                    print("City name:", cityName)
                
                }
            
        } else {
            print("Unable to determine device's location")
        }
       
         
    }
    
    func formatTemp( temp: Double) -> String
    {
        let measurement = Measurement(value: temp, unit: UnitTemperature.celsius)

        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .short
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .temperatureWithoutUnit

        return measurementFormatter.string(from: measurement)
        

    }
  
    
    struct WeatherView_Previews: PreviewProvider {
        static var previews: some View {
            WeatherView()
            
        }
    }
    
}
