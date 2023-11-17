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
    @StateObject var locationManager = LocationManager()
    
    
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        VStack {
            LocationButton {
                locationManager.requestLocation()
                fetchWeatherData()
            }
            .frame(height: 44)
            .padding()
                Text((locationManager.location?.latitude.description.lowercased()) ?? "loading location")
                Text((locationManager.location?.longitude.description.lowercased()) ?? "Your time is important for us")
                
                ForEach(viewModel.datiGiorno.datiTempo, id: \.id) { day in
                    
                    HStack{
                        Text(day.time.description)
                        Text(day.temperatura.description)
                        Text(day.weatherCode.description)
                    } .frame(minHeight: 0, maxHeight: .greatestFiniteMagnitude)
                }
        }
    }
     func fetchWeatherData() {
        print(locationManager.location?.latitude)
        print(locationManager.location?.longitude)
        viewModel.fetch(lat: locationManager.location?.latitude ?? 52.52, long: locationManager.location?.longitude ?? 13.41)
    }
}
    
struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
        
    }
}

