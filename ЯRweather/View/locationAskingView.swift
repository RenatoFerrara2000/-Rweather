//
//  locationAskingView.swift
//  ЯRweather
//
//  Created by Renato Ferrara on 16/11/23.
//

import Foundation
import SwiftUI
import CoreLocationUI

struct locationAskingView: View {
    
    @EnvironmentObject var locationManager: LocationManager
    var body: some View {
        VStack {
            WeatherView(weatherData: WeatherData(), datiGiorno: [])
                .environmentObject(locationManager)
            LocationButton(.shareCurrentLocation) {
                            locationManager.requestLocation()
                    }
                    .cornerRadius(30)
                    .symbolVariant(.fill)
                    .foregroundColor(.white)
            }
        }
    }
